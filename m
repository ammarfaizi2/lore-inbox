Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTAATEy>; Wed, 1 Jan 2003 14:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAATEx>; Wed, 1 Jan 2003 14:04:53 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:7610 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264822AbTAATEv>; Wed, 1 Jan 2003 14:04:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 1 Jan 2003 11:13:02 -0800
Message-Id: <200301011913.LAA02338@baldur.yggdrasil.com>
To: hch@infradead.org
Subject: Re: RFC/Patch - Implode devfs
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Dec 31, 2002 at 06:24:22PM -0800, Adam J. Richter wrote:
>> 	The following patch replaces devfs with a ramfs-derived
>> implementation which is under one quarter the size although it
>> eliminates certain functionality.
>> 
>> 		wc -l *.c Makefile	size (text + data + bss)
>> 
>> devfs		3614 lines		25,863 bytes
>> mini-devfs       629 lines		 5,367 bytes
>> Reduction	 5.7x			4.8x

>Wow, that looks really cool!  I just wonder where viro is hiding the last
>weeks, he promised more devfs API cleanups that likely clash with
>your changes.

	I don't know what devfs API changes he wants to make, but I
imagine that I can probably follow them.

	The one devfs quirk that I really like that one might be
tempted to eliminate is that you can pass a file_operations pointer to
devfs_register, which enables the possibility in future of being able
to build systems that just use devfs names for identifying devices.

>> 	3. devfs_handle_t is now a synonym for struct dentry*.

>I wonder whether some code uses struct devfs_entry * directly, at least
>I was tempted to do so in the scsi midlayer.

	Thankfully, struct devfs_entry* is an opaque pointer.  The
struct is only defined in fs/devfs/base.c.  Searching with
"find . -name '*.[ch]' | xargs grep -w devfs_entry" indicates
that everyone declares devfs_handle_t instead of "struct devfs_entry*",
so that's not a problem either.

	Your question prompted me to do a little bit of research.
I believe the list of routines that my reduced devfs does not
implement is as follows:

devfs_get_handle
devfs_get_handle_from_inode
devfs_set_file_size
devfs_get_info
devfs_set_info
devfs_get_parent
devfs_get_first_child
devfs_get_next_sibling
devfs_get_name
devfs_register_tape
devfs_unregister_tape
devfs_alloc_major
devfs_dealloc_major
devfs_alloc_devnum
devfs_dealloc_devnum

	Storing this list in /tmp/names and grepping for these
identifiers shows only a small number of hits:

% find . -name '*.[ch]' | xargs fgrep -l -w -f /tmp/names
./arch/i386/kernel/cpu/mtrr/if.c
./arch/i386/kernel/microcode.c
./arch/ia64/sn/io/sn1/hubcounters.c
./arch/ia64/sn/io/hcl.c
./arch/ia64/sn/io/labelcl.c
./arch/ia64/sn/kernel/sn1/synergy.c
./arch/x86_64/kernel/mtrr.c
./drivers/ide/ide-tape.c
./drivers/media/radio/miropcm20-rds.c
./drivers/scsi/osst.c
./drivers/scsi/st.c
./fs/devfs/base.c
./fs/devfs/util.c
./fs/mini-devfs/inode.c
./include/linux/devfs_fs_kernel.h

	Also, drivers/media/dvb/dvb-core/dvbdev.c has an option
to use DEVFS_F_AUTO_DEVNUM, which my devfs code does not yet support,
but, still it looks like the compatability issues may be pretty small.


>> 	4. A lot of the devfs routines are unimplemented.  I haven't
>> noticed much code that uses them, and I'm not sure that any code
>> really should.  I think arch/ia64/sn uses devfs_get_first_child,
>> devfs_get_next_sibling.  I need to understand what if any of the
>> other routines are really necessary and why (for example, why can't
>> we use struct dentry).  My computer seems to run fine without them.

>The hcl code in arch/ia64/sn/ is supposed to get replaced by a filesystem
>on it's own once the sn port is properly updated for 2.5/2.6.

	Great.


>> 	First of all, I'd like to debug this code and I'd welcome any
>> help.

>Is it supposed to work out of the box on previously (and for 2.4 use)
>non-devfs systems?  I still don't plan to use devfs, but such an effort
>is really worth some debugging help..

	Thanks for the encouragement.


>> 	I think I'd like to change fs/super.c slightly to make it
>> easier to statically allocate the struct super_block for filesystems
>> that can have only one instance even if they are mounted in multiple
>> locations (devfs, procfs, sysfs, usbdevfs, etc.).

>Why do you want to allocate it statically?

	A few fields could be initialized statically.  A few bytes
would be saved from memory allocation overhead.  Cache locality would
improve infinitesemally.  If all one-instance filesystems are changed
to do this, it will eliminate one memory allocation failure branch in
fs/super.c.  Perhaps the same could be done with the root inode.  I
know this is pretty marginal and might end up adding more complexity
than it would save.  It's at the bottom of my TODO (or "to try") list.

>> @@ -24,7 +24,11 @@
>>  #define DEVFS_SPECIAL_CHR     0
>>  #define DEVFS_SPECIAL_BLK     1
>>  
>> +#ifdef CONFIG_DEVFS_SMALL
>> +typedef struct dentry * devfs_handle_t;
>> +#else
>>  typedef struct devfs_entry * devfs_handle_t;
>> +#endif

>Do you really need to keep both around?

	I am starting by posting this as an addition in case it turns
out that there is a camp that needs the existing devfs.  If that does
not appear to be the case, then I'd be happy to make a patch to remove
the current devfs.



>> +/* On success, returns with (*parent_inode)->i_sem taken. */
>> +static int devfs_decode(devfs_handle_t dir, const char *name, int is_dir,
>> +			struct inode **parent_inode, struct dentry **dentry)

>Do we really have to support this?

	It's a static routine to support the existing devfs interface.
Later, the devfs interface can be simplified to eliminate the need
for this routine and perhaps walk_parents_mkdir.

>> +++ linux/fs/devfs2/numspace.c	2002-12-25 17:44:14.000000000 -0800
[...]
>> +int devfs_alloc_unique_number (struct unique_numspace *space)

>Remove the devfs_ prefix here (it's not devfs-specific at all) and
>convert to sane indentation?

	I'm trying to first land a patch that involves no changes to
users of devfs.  After that, I expect this code to be completely
replaced soon anyhow as a result of efforts independent of devfs
(probably by an enhanced number allocation facility for
device_interface in drivers/base/).  Currently
devfs_alloc_unique_number is used only to allocate disk numbers in
/dev/discs/discNNN/.  If my shruken devfs gets integrated and
devfs_alloc_unique_number is still in use, I'd be happy to make the
change you suggest.  I'd just rather do integration as a separate
phase from API changes to keep the patches somewhat comprehensible.

	Anyhow, thanks for all of the feedback.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
jobs
