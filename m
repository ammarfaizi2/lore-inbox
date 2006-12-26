Return-Path: <linux-kernel-owner+w=401wt.eu-S932652AbWLZPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWLZPTY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWLZPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:18:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:34460 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656AbWLZPSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=pCU6pEGovgEOQo+wNSjvnViU+6+AWjQ4hTeUC8jICKJ6d53inJdUH42RBb1cfGyEwvbUnIWBP1Hd937VjtGmGRznaaA0Pv3oeI0glqP8nZ+n684ZHOgNE3NhImH2ebvyyfntnwCf2l3LvgB8rGQIO14AelNla/6nsqDXbSBbBfw=
Subject: [RFC,PATCHSET] Managed device resources
In-Reply-To: 
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:33 +0900
Message-Id: <1167146313307-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

This patchset implements managed device resources, in short, devres.

## Intro

devres came up while trying to convert libata to use iomap.  Each
iomapped address should be kept and unmapped on driver detach.  For
example, a plain SFF ATA controller (that is, good old PCI IDE) in
native mode makes use of 5 PCI BARs and all of them should be
maintained.

As with many other device drivers, libata low level drivers have
sufficient bugs in ->remove and ->probe failure path.  Well, yes,
that's probably because libata low level driver developers are lazy
bunch, but aren't all low level driver developers?  After spending a
day fiddling with braindamaged hardware with no document or
braindamaged document, if it's finally working, well, it's working.

For one reason or another, low level drivers don't receive as much
attention or testing as core code, and bugs on driver detach or
initilaization failure doesn't happen often enough to be noticeable.
Init failure path is worse because it's much less travelled while
needs to handle multiple entry points.

So, many low level drivers end up leaking resources on driver detach
and having half broken failure path implementation in ->probe() which
would leak resources or even cause oops when failure occurs.  iomap
adds more to this mix.  So do msi and msix.

## Devres

devres is basically linked list of arbitrarily sized memory areas
associated with a struct device.  Each devres entry is associated with
a release function.  A devres can be released in several ways.  No
matter what, all devres entries are released on driver detach.  On
release, the associated release function is invoked and then the
devres entry is freed.

Managed interface is created for resources commonly used by device
drivers using devres.  For example, coherent DMA memory is acquired
using dma_alloc_coherent().  The managed version is called
dmam_alloc_coherent().  It is identical to dma_alloc_coherent() except
for the DMA memory allocated using it is managed and will be
automatically released on driver detach.  Implementation looks like
the following.

  struct dma_devres {
	size_t		size;
	void		*vaddr;
	dma_addr_t	dma_handle;
  };

  static void dmam_coherent_release(struct device *dev, void *res)
  {
	struct dma_devres *this = res;

	dma_free_coherent(dev, this->size, this->vaddr, this->dma_handle);
  }

  dmam_alloc_coherent(dev, size, dma_handle, gfp)
  {
	struct dma_devres *dr;
	void *vaddr;

	dr = devres_alloc(dmam_coherent_release, sizeof(*dr), gfp);
	...

	/* alloc DMA memory as usual */
	vaddr = dma_alloc_coherent(...);
	...

	/* record size, vaddr, dma_handle in dr */
	dr->vaddr = vaddr;
	...

	devres_add(dev, dr);

	return vaddr;
  }

If a driver uses dmam_alloc_coherent(), the area is guaranteed to be
freed whether initialization fails half-way or the device gets
detached.  If most resources are acquired using managed interface, a
driver can have much simpler init and exit code.  Init path basically
looks like the following.

  my_init_one()
  {
	struct mydev *d;

	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
	if (!d)
		return -ENOMEM;

	d->ring = dmam_alloc_coherent(...);
	if (!d->ring)
		return -ENOMEM;

	if (check something)
		return -EINVAL;
	...

	return register_to_upper_layer(d);
  }

And exit path,

  my_remove_one()
  {
	unregister_from_upper_layer(d);
	shutdown_my_hardware();
  }

As shown above, low level drivers can be simplified a lot by using
devres.  Complexity is shifted from less maintained low level drivers
to better maintained higher layer.  Also, as init failure path is
shared with exit path, both can get more testing.

## Devres group

Devres entries can be grouped using devres group.  When a group is
released, all contained normal devres entries and properly nested
groups are released.  One usage is to rollback series of acquired
resources on failure.  For example,

  if (!devres_open_group(dev, NULL, GFP_KERNEL))
	return -ENOMEM;

  acquire A;
  if (failed)
	goto err;

  acquire B;
  if (failed)
	goto err;
  ...

  devres_remove_group(dev, NULL);

  return 0;

 err:
  devres_release_group(dev, NULL);
  return err_code;

As resource acquision failure usually means probe failure, constructs
like above are usually useful in midlayer driver (e.g. libata core
layer) where interface function shouldn't have side effect on failure.
For LLDs, just returning error code suffices in most cases.

## Details

Lifetime of a devres entry begins on devres allocation and finishes
when it is released or destroyed (removed and freed) - no reference
counting.

devres core guarantees atomicity to all basic devres operations and
has support for single-instance devres types (atomic
lookup-and-add-if-not-found).  Other than that, synchronizing
concurrent accesses to allocated devres data is caller's
responsibility.  This is usually non-issue because bus ops and
resource allocations already do the job.

All devres interface functions can be called without context if the
right gfp mask is given.

## Overhead

Each devres bookkeeping info is allocated together with requested data
area.  With debug option turned off, bookkeeping info occupies 16
bytes on 32bit machines and 24 bytes on 64bit (three pointers rounded
up to ull alignment).  If singly linked list is used, it can be
reduced to two pointers (8 bytes on 32bit, 16 bytes on 64bit).

Each devres group occupies 8 pointers.  It can be reduced to 6 if
singly linked list is used.

Memory space overhead on ahci controller with two ports is between 300
and 400 bytes on 32bit machine after naive conversion (we can
certainly invest a bit more effort into libata core layer).

## Patchset

This patchset contains the following 12 patches and is against the
current 2.6.20-rc2 (3bf8ba38f38d3647368e4edcf7d019f9f8d9184a).

01	: implement devres core
02-06	: implement managed resource interface for IO region, IRQ, DMA,
	  PCI and iomap
07	: libata fix (just included for following patches, please
	  ignore for review)
08	: update libata core layer to use devres
09	: update SATA LLDs to use devres
10	: remove unused parts
11	: implement pcim_iomap_regions()
12	: convert libata to iomap

Patches #01-06 implements devres and #08-12 apply it to libata.  The
libata part is not complete as none of PATA drivers is converted yet,
so, patch #10 will break libata PATA drivers.  Other than that
everything should work.

New config option CONFIG_DEBUG_DEVRES is added.  If set, kernel
parameter devres.log is available.  If set, it will log devres
activities.  This can be turned on/off using sysfs node.

Thanks.  Happy new year.

--
tejun


