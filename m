Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTA1JMb>; Tue, 28 Jan 2003 04:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTA1JMb>; Tue, 28 Jan 2003 04:12:31 -0500
Received: from smtp2.Stanford.EDU ([171.64.14.116]:9699 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261724AbTA1JM2>; Tue, 28 Jan 2003 04:12:28 -0500
Date: Tue, 28 Jan 2003 01:21:11 -0800 (PST)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: <yxie@glide.stanford.edu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in
 2.5.53
In-Reply-To: <Pine.LNX.4.33L2.0301272328210.28277-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.OSF.4.33.0301280104520.272436-100000@glide.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, Thanks for the quick feedback! I had some additional comments
below starting with '%'. -Yichen

---------------------------------------------------------
% I was thinking about the case where "de" is NULL and "old"
% gets garbage from the stack (since there's no initializer);
% _devfs_alloc_entry won't be called in this case...

# This one is OK.  _devfs_append_entry() sets <old>.
[BUG] "old" might get garbage on the stack
/home/yxie/linux-2.5.53/fs/devfs/base.c:1179:_devfs_make_parent_for_leaf
: ERROR:BUFFER:1179:1179:Dereferencing uninitialized pointer (*old)
evaluated in the following state
	    de = _devfs_alloc_entry (name, next_pos, MODE_DIR);
	    devfs_get (de);
	    if ( !de || _devfs_append_entry (dir, de, FALSE, &old) )
	    {
		devfs_put (de);

Error --->
		if ( !old || !S_ISDIR (old->mode) )
		{
		    devfs_put (old);
		    devfs_put (dir);
---------------------------------------------------------
% In the definition of split_status_strings (line #683),
% Comma after the first string is missing, so the first and
% second string are concatenated together to form one element
% --the array only has 7 elements, instead of 8.

# I don't see the problem....
[BUG] missing comma in definition of split_status_strings
/home/yxie/linux-2.5.53/drivers/scsi/aic7xxx/aic79xx_pci.c:808:ahd_pci_s
plit_intr: ERROR:BUFFER:808:808:Array bounds error (off >= len) [RANGE]
(split_status_strings[bit], len = 7, off = sym_42005934, max(off-len) =
0)
		for (bit = 0; bit < 8; bit++) {

			if ((split_status[i] & (0x1 << bit)) != 0) {
				static const char *s;


Error --->
				s = split_status_strings[bit];
				printf(s, ahd_name(ahd),
				       split_status_source[i]);
			}
---------------------------------------------------------
% similar reason as above; missing comma after "REQ_SPECIAL"

# Don't see a problem here....
[BUG] missing comma in rq_flags
/home/yxie/linux-2.5.53/drivers/block/ll_rw_blk.c:685:blk_dump_rq_flags:
ERROR:BUFFER:685:685:Array bounds error (off >= len) (rq_flags[bit], len
= 17, off = 17, min(off-len) = 0)
	printk("%s: dev %s: flags = ", msg,
		rq->rq_disk ? rq->rq_disk->disk_name : "?");
	bit = 0;
	do {
		if (rq->flags & (1 << bit))

Error --->
			printk("%s ", rq_flags[bit]);
		bit++;
	} while (bit < __REQ_NR_BITS);

---------------------------------------------------------
% as i suspected... ;-)

# Comment in struct says that its size there is a placeholder........
[BUG] suspicious, since sizeof cmd is 2 (not 0 or 1, which is commonly
used for buffers)
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:209:i2cmdUnixFlags:
ERROR:BUFFER:209:209:Array bounds error (off >= len) ((*pCM).cmd[6], len
= 2, off = 6, min(off-len) = 4)
	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;

Error --->
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
	return pCM;
}

---------------------------------------------------------
% hmm.. looks like a bug in our checker :p

# But if unit is 0 and becomes -1, that shouldn't be executed??
I.e., I think this code is OK; it's just confusing.
[BUG]
/home/yxie/linux-2.5.53/drivers/ide/ide-probe.c:1055:alloc_disks:
ERROR:BUFFER:1055:1055:Array bounds error (off < 0) [RANGE]
(disks[unit], min(off) = -1)
	}
	return 0;
Enomem:
	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
	while (unit--)

Error --->
		put_disk(disks[unit]);
	return -ENOMEM;
}


