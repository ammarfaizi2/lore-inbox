Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUFWDpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUFWDpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUFWDpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:45:38 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:61340 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264963AbUFWDpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:45:36 -0400
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       zwane@linuxpower.ca, eli@mellanox.co.il
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 20:45:34 -0700
In-Reply-To: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com> (long's
 message of "Tue, 22 Jun 2004 14:48:10 -0700")
Message-ID: <52d63rj5sx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jun 2004 03:45:34.0419 (UTC) FILETIME=[89F6F230:01C458D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of other comments on the patch:

  > +Argument entries is a pointer of unsigned integer type. The number of
  > +elements is indicated in argument nvec. The content of each element 
  > +will be mapped to the following struct defined in /driver/pci/msi.h.
  > +
  > +struct msix_entry {
  > +	__u32 	vector	: 16; /* kernel uses to write alloc vector */
  > +	__u32	entry	: 16; /* driver uses to specify entry */
  > +};
  > +
  > +A device driver is responsible for initializing the field entry of 
  > +each element with unique entry supported by MSI-X table.

I think this structure should be defined in a header in include/linux,
probably <linux/pci.h>.  We could create a new <linux/msi.h> include
but I don't think it's worth it at this point.  Also I don't see any
reason to use bitfields or userspace types like __u32 (since no
userspace code is going to use this include file).  I would just
declare the type as

struct msix_entry {
       u16 vector;
       u16 entry;
};

  > +int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec)

Since this function takes an array of struct msix_entry in its entries
parameter, I think entries should be declared as struct msix_entry *
rather than just u32 *.  That is, I would write the prototype as

int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
		    int nvec);

  > +		j = (entries + i)->entry;
  > +		(entries + i)->vector = vector;

Finally, this is a nitpick, but this just looks odd to me.  Why not
write this as

                j = entries[i].entry;
                entries[i].vector = vector;

By the way, I have MSI working with my device with this patch
applied.  I am getting ready to test MSI-X, which is why I have
comments about the MSI-X API now.

 - Roland


