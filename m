Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSKVXe1>; Fri, 22 Nov 2002 18:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKVXe1>; Fri, 22 Nov 2002 18:34:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13168 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265424AbSKVXeU>; Fri, 22 Nov 2002 18:34:20 -0500
Date: Fri, 22 Nov 2002 18:43:12 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: One more change pushed to bk tree
Message-ID: <20021122234312.GD18664@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
References: <20021122183603.GC16865@redhat.com> <20021122222459.GC18664@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20021122222459.GC18664@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 22, 2002 at 05:24:59PM -0500, Doug Ledford wrote:
> On Fri, Nov 22, 2002 at 01:36:03PM -0500, Doug Ledford wrote:
> > Like last time, this has been through a full compile test, but not a boot 
> > test.  I'm heading up to the office next so the boot test will come 
> > shortly.
> 
> BTW, boot and run tests were successful.  No I'm trying to isolate why 
> certain modules blow up when you load them, unload them, then reload them.  
> Right now, the aic7xxx_old, sd_mod, and scsi_mod modules are working.  The 
> st module is blowing chunks.  I haven't tried sr_mod yet.  I also haven't 
> tried any other lldd modules yet.
> 
> Anyway, back to hacking st.c

st.c problem solved.  At this point, these changes are ready for sucking 
up by Linus.

bk pull bk://linux-scsi.bkbits.net/scsi-dledford

when you have network connectivity again Linus ;-)

There are two more new Changesets at the top of the changeset list 
relative to my last email, plus the tree has been merged with 2.4.49 
since my last email.  The total local changeset list is attached.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="changes.list"

ChangeSet@1.855, 2002-11-22 18:26:02-05:00, dledford@aladin.rdu.redhat.com
  fs/proc/inode.c: Make proc use new module loader semantics so that
  	touching a /proc/* file doesn't pin a module in memory

ChangeSet@1.854, 2002-11-22 18:25:05-05:00, dledford@aladin.rdu.redhat.com
  st.c:   Clean up init failure paths
  	Fix the detach code so it doesn't call sysfs unregister with
  		a lock held

ChangeSet@1.853, 2002-11-22 17:53:11-05:00, dledford@flossy.devel.redhat.com
  Merge bk://linux.bkbits.net/linux-2.5
  into flossy.devel.redhat.com:/usr/local/home/dledford/bk/linus-2.5

ChangeSet@1.852, 2002-11-22 12:59:10-05:00, dledford@dledford.theledfords.org
  Convert from host->host_queue to host->my_devices list usage
  Add in usage of new same_target_siblings list
  Add scsi_release_commandblocks() call to scsi_free_sdev()
  Make all scsi device freeing use scsi_free_sdev()

ChangeSet@1.851, 2002-11-22 00:36:31-05:00, dledford@dledford.theledfords.org
  scsi: Update lldd API to slave_alloc/slave_configure/slave_destroy interface
  	instead of slave_attach/slave_detach interface.  Change all users
  	of existing interface to new interface, update scan code for new
  	device attachement semantics

ChangeSet@1.842.29.10, 2002-11-21 11:59:45-06:00, patmans@us.ibm.com
  [PATCH] cleanup code for /proc add/remove single device
  
  On Thu, Nov 21, 2002 at 02:23:14AM +0100, Christoph Hellwig wrote:
  > two new helpers in scsi_scan.c: scsi_add_single_device and
  > scsi_remove_single_device that do all hard work.  Thanks to
  > beeing in scsi_scan.c and using proper helpers they're a lot
  > smaller and cleaner.
  >
  >
  > --- 1.44/drivers/scsi/scsi.h	Sun Nov 17 16:44:35 2002
  > +++ edited/drivers/scsi/scsi.h	Thu Nov 21 01:05:39 2002
  > -
  > -		err = -ENOSYS;
  > -		if (sdev)
  > -			goto out;	/* We do not yet support unplugging */
  > -
  > -		scan_scsis(shost, 1, channel, id, lun);
  > -		err = length;
  > -		goto out;
  > -	}
  > +		err = scsi_add_single_device(host, channel, id, lun);
  > +		if (err >= 0)
  > +			err = length;
  
  > ===== drivers/scsi/scsi_scan.c 1.38 vs edited =====
  > --- 1.38/drivers/scsi/scsi_scan.c	Sun Nov 17 16:47:20 2002
  > +++ edited/drivers/scsi/scsi_scan.c	Thu Nov 21 01:16:03 2002
  > @@ -1862,6 +1862,69 @@
  >
  >  }
  >
  > +int scsi_add_single_device(uint host, uint channel, uint id, uint lun)
  > +{
  > +	struct scsi_device *sdevscan, *sdev;
  > +	struct Scsi_Host *shost;
  > +	int error = -ENODEV;
  > +
  > +	shost = scsi_host_hn_get(host);
  > +	if (!shost)
  > +		return -ENODEV;
  > +	sdev = scsi_find_device(shost, channel, id, lun);
  > +	if (!sdev)
  > +		goto out;
  > +
  
  James/Christoph -
  
  I had to change the above to a "if (sdev)" per the following patch (against
  current scsi-misc-2.5) to get the add to work correctly. Otherwise, this
  worked fine.

ChangeSet@1.842.29.9, 2002-11-21 11:59:33-06:00, patmans@us.ibm.com
  [PATCH] current scsi-misc-2.5 include files
  
  On Thu, Nov 21, 2002 at 10:12:23AM -0600, J.E.J. Bottomley wrote:
  > The scsi-misc-2.5 resync should be done now.
  >
  > James
  
  Hi -
  
  hardirq.h and init.h were removed from scsi.h. So I had to make the
  following changes to compile. I also removed two extraneous includes.

ChangeSet@1.849, 2002-11-21 12:55:58-05:00, dledford@aladin.rdu.redhat.com
  Merge aladin.rdu.redhat.com:/usr/local/home/dledford/bk/linus-2.5
  into aladin.rdu.redhat.com:/usr/src/2.5

ChangeSet@1.842.29.8, 2002-11-21 10:06:03-06:00, hch@lst.de
  [PATCH] turn scsi_allocate_device into readable code

ChangeSet@1.842.29.7, 2002-11-21 10:05:24-06:00, hch@lst.de
  [PATCH] some HBA compile warning fixes

ChangeSet@1.842.29.6, 2002-11-21 10:04:47-06:00, hch@lst.de
  [PATCH] remove useless includes from scsi.h

ChangeSet@1.842.29.5, 2002-11-21 10:04:16-06:00, hch@lst.de
  [PATCH] get rid of scan_scsis
  
  this function was a multiplexer for two very different things, but
  with my last patch one of those faded away and only one callers
  is left.  Simplify it to what's still needed and rename to
  scsi_scan_host.

ChangeSet@1.842.29.4, 2002-11-21 10:03:50-06:00, hch@lst.de
  [PATCH] cleanup code for /proc add/remove single device
  
  two new helpers in scsi_scan.c: scsi_add_single_device and
  scsi_remove_single_device that do all hard work.  Thanks to
  beeing in scsi_scan.c and using proper helpers they're a lot
  smaller and cleaner.

ChangeSet@1.842.29.3, 2002-11-21 10:03:28-06:00, hch@lst.de
  [PATCH] make a few more routines private to scsi_lib.c

ChangeSet@1.842.29.2, 2002-11-21 10:03:10-06:00, hch@lst.de
  [PATCH] split busy check out of scsi_remove_host
  
  just a simple code cleanup

ChangeSet@1.842.29.1, 2002-11-21 10:02:57-06:00, hch@lst.de
  [PATCH] remove unused include in scsi_ioctl.c
  
  This time I explicitly checked for the in_atomic mess..

ChangeSet@1.848, 2002-11-20 19:05:37-05:00, dledford@aladin.rdu.redhat.com
  Merge aladin.rdu.redhat.com:/usr/local/home/dledford/bk/linus-2.5
  into aladin.rdu.redhat.com:/usr/src/2.5

ChangeSet@1.846.1.1, 2002-11-20 19:05:09-05:00, dledford@aladin.rdu.redhat.com
  scsi.c, scsi.h, scsi_syms.c, aic7xxx_old: add new function to track queue
  	full events at the mid layer instead of at the low level device
  	driver

ChangeSet@1.845, 2002-11-19 17:07:50-05:00, dledford@flossy.devel.redhat.com
  Merge bk://linux.bkbits.net/linux-2.5
  into flossy.devel.redhat.com:/usr/local/home/dledford/bk/linus-2.5

ChangeSet@1.825.7.2, 2002-11-17 22:09:07-05:00, dledford@aladin.rdu.redhat.com
  aic7xxx_old: update biosparam function with the (ugly) detail that
  	cylinder values > 65535 get truncated

ChangeSet@1.825.7.1, 2002-11-17 18:57:50-05:00, dledford@aladin.rdu.redhat.com
  aic7xxx_old: fix up the biosparam function to do 64bit math safely


--pf9I7BMVVzbSWLtt--
