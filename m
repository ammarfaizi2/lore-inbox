Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRIDVHX>; Tue, 4 Sep 2001 17:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRIDVHO>; Tue, 4 Sep 2001 17:07:14 -0400
Received: from saga18.Stanford.EDU ([171.64.15.148]:54755 "EHLO
	saga18.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S269223AbRIDVGv>; Tue, 4 Sep 2001 17:06:51 -0400
Date: Tue, 4 Sep 2001 14:07:05 -0700 (PDT)
From: Kenneth Michael Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] security errors for 2.4.9 and 2.4.9-ac7
Message-ID: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've extended the security checker (makes sure that user lengths are
bounds checked) quite a bit since my last report on July 13.  The checker
makes sure that bounds checks are present before a user length is:

	1. passed as a length argument to copy_*user (or passed to a
		function that does)
	2. is used as an array index.
	3. passed as the size argument to *malloc (this is a minor bug
		as *malloc will fail if the size is too large, but bad
		things can happen if the argument overflows because of
		multiplication (i.e. the argument to malloc is
		(userlen * sizeof(struct big_struct)) and only a small
		amount of memory is alloc'd instead))
		These errors are marked with "LOCAL MINOR" so you can ignore
		them if you don't want them.
	4. used as part of the conditional expression of a loop (most of
		the time these errors result in the user being able to
		make the loop go for a long time.)
	5. passed to any function that does one of the above things.

The checker not only looks at user lengths that it knows come
directly from the user (via copy_from_user, get_user, etc.), but it can also
infer that a length comes from the user:  Ioctl's often have an argument
passed to them that is used in different ways-- in one case of a switch
statement, it could be the destination of copy_to_user and in another case,
it could be the length argument of copy_from_user.  If that parameter is a
destination for copy_to_user or the source for copy_from_user, we infer that
it comes from the user and we look at other uses of it in the same function.

We also look at data that comes off the network (meaning that it comes out
of an skb).  While it is difficult to determine if the data in incoming or
outgoing, I'm pretty sure that the errors here are valid.

We also check when a user length is passed to a function pointer.  I made
a list of all functions that are assigned to that field and if one of those
functions does the bad things listed above, it is marked as an error.  It is
possible that the function pointer could not actually be that function at
that point in the code.  This type of error is notated with "Possibly using
user length..."

Furthermore, there are some functions that the kernel sometimes does bounds
checking before passing a user length to them.  The places where they don't do
bounds checking were flagged as errors, but I'm not sure if the bounds checks
are necessary for these functions (the number after each function name is the
parameter for which the kernel did bounds checking):

virt_to_phys:0:
pci_map_single:2:
drm_alloc:0:
int_to_bcd:0:
drm_ioremap:0:
outb:0:
outw:0:

Please tell me if those functions really need bounds checking or not.

As always, any suggestions for improvements are welcome.

Ken Ashcraft
kash@stanford.edu

# Summary for
#  2.4.9-specific errors       	= 5
#  2.4.9ac7-specific errors 	= 23
#  Common errors 		= 84
#  Total 			= 112



# BUGs	|	File Name
12	|	/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c/
6	|	/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c/
6	|	/home/kash/linux/2.4.9/drivers/char/moxa.c/
5	|	/home/kash/linux/2.4.9/drivers/char/vt.c/
5	|	/home/kash/linux/2.4.9/drivers/block/DAC960.c/
3	|	/home/kash/linux/2.4.9-ac7/drivers/scsi/dpt_i2o.c/
3	|	/home/kash/linux/2.4.9-ac7/drivers/md/lvm.c/
3	|	/home/kash/linux/2.4.9/drivers/media/video/zr36067.c/
3	|	/home/kash/linux/2.4.9/drivers/atm/nicstar.c/
3	|	/home/kash/linux/2.4.9/net/bluetooth/hci_core.c/
3	|	/home/kash/linux/2.4.9/drivers/block/cciss.c/
2	|	/home/kash/linux/2.4.9/drivers/block/floppy.c/
2	|	/home/kash/linux/2.4.9/drivers/net/wan/lmc/lmc_main.c/
2	|	/home/kash/linux/2.4.9/drivers/sound/wavfront.c/
2	|	/home/kash/linux/2.4.9/drivers/char/isicom.c/
2	|	/home/kash/linux/2.4.9/net/ipv6/netfilter/ip6_tables.c/
2	|	/home/kash/linux/2.4.9/drivers/net/wan/sdla.c/
2	|	/home/kash/linux/2.4.9/drivers/char/sx.c/
2	|	/home/kash/linux/2.4.9/drivers/char/drm/radeon_state.c/
2	|	/home/kash/linux/2.4.9/drivers/isdn/hisax/isar.c/
2	|	/home/kash/linux/2.4.9/drivers/media/video/zr36120.c/
2	|	/home/kash/linux/2.4.9/drivers/cdrom/cdrom.c/
2	|	/home/kash/linux/2.4.9/fs/ncpfs/ioctl.c/
2	|	/home/kash/linux/2.4.9/drivers/isdn/tpam/tpam_commands.c/
2	|	/home/kash/linux/2.4.9-ac7/drivers/scsi/cpqfcTSinit.c/
2	|	/home/kash/linux/2.4.9/drivers/telephony/ixj.c/
2	|	/home/kash/linux/2.4.9/net/ipv4/netfilter/ip_tables.c/
1	|	/home/kash/linux/2.4.9/drivers/net/hamradio/soundmodem/sm_sbc.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wireless/orinoco.c/
1	|	/home/kash/linux/2.4.9/drivers/video/fbmem.c/
1	|	/home/kash/linux/2.4.9/drivers/media/video/stradis.c/
1	|	/home/kash/linux/2.4.9/drivers/char/tpqic02.c/
1	|	/home/kash/linux/2.4.9/drivers/usb/devio.c/
1	|	/home/kash/linux/2.4.9/drivers/md/lvm.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wan/cosa.c/
1	|	/home/kash/linux/2.4.9/drivers/cdrom/sbpcd.c/
1	|	/home/kash/linux/2.4.9/drivers/video/matrox/matroxfb_crtc2.c/
1	|	/home/kash/linux/2.4.9/drivers/i2c/i2c-dev.c/
1	|	/home/kash/linux/2.4.9/net/socket.c/
1	|	/home/kash/linux/2.4.9-ac7/net/bluetooth/hci_core.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wan/sdlamain.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wan/sbni.c/
1	|	/home/kash/linux/2.4.9-ac7/drivers/media/video/stradis.c/
1	|	/home/kash/linux/2.4.9/drivers/scsi/megaraid.c/
1	|	/home/kash/linux/2.4.9/drivers/char/istallion.c/
1	|	/home/kash/linux/2.4.9-ac7/drivers/usb/ov511.c/
1	|	/home/kash/linux/2.4.9/drivers/isdn/act2000/act2000_isa.c/
1	|	/home/kash/linux/2.4.9/net/irda/af_irda.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wan/farsync.c/
1	|	/home/kash/linux/2.4.9/drivers/net/ppp_generic.c/
1	|	/home/kash/linux/2.4.9/drivers/isdn/act2000/capi.c/
1	|	/home/kash/linux/2.4.9/drivers/char/agp/agpgart_fe.c/
1	|	/home/kash/linux/2.4.9/drivers/net/wan/sdla_fr.c/
1	|	/home/kash/linux/2.4.9/net/atm/common.c/
1	|	/home/kash/linux/2.4.9/drivers/ide/ide-tape.c/



############################################################
# 2.4.9 specific errors
#
---------------------------------------------------------
[BUG] minor.  no upper bound on clipcount
/home/kash/linux/2.4.9/drivers/media/video/stradis.c:1457:saa_ioctl: ERROR:RANGE:1451:1457: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1457 [linkages -> 1451:vw:start] [distance=24]
			saa7146_set_winsize(saa);

			/*
			 *    Do any clips.
			 */
Start --->
			if (vw.clipcount < 0) {
				if (copy_from_user(saa->dmavid2, vw.clips,
						   VIDEO_CLIPMAP_SIZE))
					return -EFAULT;
			} else if (vw.clipcount > 0) {
				if ((vcp = vmalloc(sizeof(struct video_clip) *
Error --->
					        (vw.clipcount))) == NULL)
					 return -ENOMEM;
				if (copy_from_user(vcp, vw.clips,
					      sizeof(struct video_clip) *
---------------------------------------------------------
[BUG] it looks like there are a bunch of places in this function where arg is used as an array access.
/home/kash/linux/2.4.9/drivers/telephony/ixj.c:5120:ixj_ioctl: ERROR:RANGE:4686:5120: Using user length "arg" as an array indexfor "ixj" [state = tainted] set by 'inferred by call to copy_from_user, line 5096':4686
	unsigned int minor = MINOR(inode->i_rdev);
	unsigned int board = NUM(inode->i_rdev);
	IXJ *j = ixj[board];
	int retval = 0;

Start --->
	if (ixjdebug > 1)

	... DELETED 428 lines ...

		ixj_play_stop(ixj[arg]);
		idle(j);
		idle(ixj[arg]);
		break;
	case IXJCTL_INTERCOM_START:
Error --->
		if (ixj[arg] == NULL)
			return -ENODEV;

		j->intercom = arg;
---------------------------------------------------------
[BUG] not sure.  the assignment to this fn pointer happens in sis_main.c
/home/kash/linux/2.4.9/drivers/video/matrox/matroxfb_crtc2.c:535:matroxfb_dh_ioctl: ERROR:RANGE:0:535: [FN-PTR] Possibly using user length "arg" as argumentto "sisfb_ioctl" [type=GLOBAL] [state = tainted] set by 'inferred by call to copy_to_user, line 527':0 [linkages -> 0:(null):start] [distance=7]
---------------------------------------------------------
[BUG] needs upper bound
/home/kash/linux/2.4.9/drivers/cdrom/cdrom.c:2019:mmc_ioctl: ERROR:RANGE:2012:2019: [LOOP] Looping on user length "nr" set by 'copy_from_user':2018 [linkages -> 2018:nr=nframes -> 2012:ra:start] [distance=26]
			lba = ra.addr.lba;
		else
			return -EINVAL;

		/* FIXME: we need upper bound checking, too!! */
Start --->
		if (lba < 0 || ra.nframes <= 0)
			return -EINVAL;

		/*
		 * start with will ra.nframes size, back down if alloc fails
		 */
		nr = ra.nframes;
Error --->
		do {
			cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
			if (cgc.buffer)
				break;
---------------------------------------------------------
[BUG] not sure.
/home/kash/linux/2.4.9/drivers/video/fbmem.c:514:fb_ioctl: ERROR:RANGE:0:514: [FN-PTR] Possibly using user length "arg" as argumentto "sisfb_ioctl" [type=GLOBAL] [state = tainted] set by 'inferred by call to copy_from_user, line 486':0 [linkages -> 0:(null):start] [distance=34]


############################################################
# 2.4.9ac7 specific errors

#
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9-ac7/drivers/scsi/cpqfcTSinit.c:529:cpqfcTS_ioctl: ERROR:RANGE:527:529: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'inferred by call to copy_to_user, line 619':527 [distance=12]
		return( -EFAULT);

	vendor_cmd = ioc.argp;  // i.e., CPQ specific command struct

	// If necessary, grab a kernel/DMA buffer
Start --->
	if( vendor_cmd->len)
	{
Error --->
  	  buf = kmalloc( vendor_cmd->len, GFP_KERNEL);
	  if( !buf)
	    return -ENOMEM;
	}
---------------------------------------------------------
[BUG] minor...protected by kmalloc call
/home/kash/linux/2.4.9-ac7/drivers/scsi/cpqfcTSinit.c:543:cpqfcTS_ioctl: ERROR:RANGE:527:543: Using user length "len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'inferred by call to copy_to_user, line 619':527 [distance=34]
		return( -EFAULT);

	vendor_cmd = ioc.argp;  // i.e., CPQ specific command struct

	// If necessary, grab a kernel/DMA buffer
Start --->
	if( vendor_cmd->len)

	... DELETED 10 lines ...


        // Need data from user?
	// make sure caller's buffer is in kernel space.
	if( (vendor_cmd->rw_flag == VENDOR_WRITE_OPCODE) &&
	    vendor_cmd->len)
Error --->
        if(  copy_from_user( buf, vendor_cmd->bufp, vendor_cmd->len))
		return( -EFAULT);

	// copy the CDB (if/when MAX_COMMAND_SIZE is 16, remove copy below)
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:911:presto_psdev_ioctl: ERROR:RANGE:906:911: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':906 [distance=63]
                        EXIT;
                        return error;
                }
                user_path = input.path;

Start --->
                PRESTO_ALLOC(input.path, char *, input.path_len + 1);
                if ( !input.path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(input.path, user_path, input.path_len);
                if ( error ) {
                        EXIT;
                        PRESTO_FREE(input.path, input.path_len + 1);
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:987:presto_psdev_ioctl: ERROR:RANGE:982:987: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':982 [distance=63]
                        EXIT;
                        return error;
                }
                user_path = input.path;

Start --->
                PRESTO_ALLOC(input.path, char *, input.path_len + 1);
                if ( !input.path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(input.path, user_path, input.path_len);
                if ( error ) {
                        EXIT;
                        PRESTO_FREE(input.path, input.path_len + 1);
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:448:presto_psdev_ioctl: ERROR:RANGE:443:448: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':443 [distance=63]
                if ( error ) {
                        EXIT;
                        return error;
                }

Start --->
                PRESTO_ALLOC(path, char *, input.path_len + 1);
                if ( !path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(path, input.path, input.path_len);
                if ( error ) {
                        PRESTO_FREE(path, input.path_len + 1);
                        EXIT;
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:564:presto_psdev_ioctl: ERROR:RANGE:558:564: Using user length "name_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':558 [distance=63]
                        EXIT;
                        goto exit_free_path;
                }
                path[input.path_len] = '\0';

Start --->
                PRESTO_ALLOC(fsetname, char *, input.name_len + 1);
                if ( !fsetname ) {
                        error = -ENOMEM;
                        EXIT;
                        goto exit_free_path;
                }
Error --->
                error = copy_from_user(fsetname, input.name, input.name_len);
                if ( error ) {
                        EXIT;
                        goto exit_free_fsetname;
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:496:presto_psdev_ioctl: ERROR:RANGE:491:496: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':491 [distance=63]
                if ( error ) {
                        EXIT;
                        return error;
                }

Start --->
                PRESTO_ALLOC(path, char *, input.path_len + 1);
                if ( !path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(path, input.path, input.path_len);
                if ( error ) {
                        PRESTO_FREE(path, input.path_len + 1);
                        EXIT;
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:409:presto_psdev_ioctl: ERROR:RANGE:404:409: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':404 [distance=63]
                if ( error ) {
                        EXIT;
                        return error;
                }

Start --->
                PRESTO_ALLOC(path, char *, input.path_len + 1);
                if ( !path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(path, input.path, input.path_len);
                if ( error ) {
                        PRESTO_FREE(path, input.path_len + 1);
                        EXIT;
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:551:presto_psdev_ioctl: ERROR:RANGE:546:551: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':546 [distance=63]
                if ( error ) {
                        EXIT;
                        return error;
                }

Start --->
                PRESTO_ALLOC(path, char *, input.path_len + 1);
                if ( !path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(path, input.path, input.path_len);
                if ( error ) {
                        EXIT;
                        goto exit_free_path;
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:867:presto_psdev_ioctl: ERROR:RANGE:862:867: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':862 [distance=63]
                        EXIT;
                        return error;
                }
                user_path = input.path;

Start --->
                PRESTO_ALLOC(input.path, char *, input.path_len + 1);
                if ( !input.path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(input.path, user_path, input.path_len);
                if ( error ) {
                        EXIT;
                        PRESTO_FREE(input.path, input.path_len + 1);
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:950:presto_psdev_ioctl: ERROR:RANGE:945:950: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':945 [distance=63]
                        EXIT;
                        return error;
                }
                user_path = input.path;

Start --->
                PRESTO_ALLOC(input.path, char *, input.path_len + 1);
                if ( !input.path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(input.path, user_path, input.path_len);
                if ( error ) {
                        EXIT;
                        PRESTO_FREE(input.path, input.path_len + 1);
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:1026:presto_psdev_ioctl: ERROR:RANGE:1021:1026: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1021 [distance=63]
                        EXIT;
                        return error;
                }
                user_path = input.path;

Start --->
                PRESTO_ALLOC(input.path, char *, input.path_len + 1);
                if ( !input.path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(input.path, user_path, input.path_len);
                if ( error ) {
                        EXIT;
                        PRESTO_FREE(input.path, input.path_len + 1);
---------------------------------------------------------
[BUG] alloc'd size could overflow
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:368:presto_psdev_ioctl: ERROR:RANGE:363:368: Using user length "path_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':363 [distance=63]
                if ( error ) {
                        EXIT;
                        return error;
                }

Start --->
                PRESTO_ALLOC(path, char *, input.path_len + 1);
                if ( !path ) {
                        EXIT;
                        return -ENOMEM;
                }
Error --->
                error = copy_from_user(path, input.path, input.path_len);
                if ( error ) {
                        PRESTO_FREE(path, input.path_len + 1);
                        EXIT;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9-ac7/fs/intermezzo/psdev.c:289:presto_psdev_ioctl: ERROR:RANGE:287:289: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_lb] set by 'copy_from_user':287 [linkages -> 287:len=io_len -> 287:readmount->io_len -> 287:readmount:start] [distance=13]
                                &readmount);
                        EXIT;
                        return error;
                }

Start --->
                len = readmount.io_len;
                minor = MINOR(dev);
Error --->
                PRESTO_ALLOC(tmp, char *, len);
                if (!tmp) {
                        EXIT;
                        return -ENOMEM;
---------------------------------------------------------
[BUG] could overflow
/home/kash/linux/2.4.9-ac7/net/bluetooth/hci_core.c:834:hci_conn_list: ERROR:RANGE:829:834: Using user length "size" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':829 [linkages -> 829:size=(null) -> 829:conn_num op (null) -> 829:req->conn_num -> 829:req:start] [distance=13]
		return -EFAULT;

	if (!(hdev = hci_dev_get(req.dev_id)))
		return -ENODEV;

Start --->
	size = req.conn_num * sizeof(struct hci_conn_info) + sizeof(req);

	if (verify_area(VERIFY_WRITE, (void *)arg, size))
		return -EFAULT;

Error --->
	if (!(cl = kmalloc(size, GFP_KERNEL)))
		return -ENOMEM;
	ci = cl->conn_info;

---------------------------------------------------------
[BUG] array index
/home/kash/linux/2.4.9-ac7/drivers/scsi/dpt_i2o.c:1962:adpt_ioctl: ERROR:RANGE:1962:1962: Using user length "channel" as argument to "adpt_find_device" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':1962 [distance=1]

		if (copy_from_user((void*)&busy, (void*)arg, sizeof(TARGET_BUSY_T))) {
			return -EFAULT;
		}


Error --->
		d = adpt_find_device(pHba, busy.channel, busy.id, busy.lun);
---------------------------------------------------------
[BUG] array index
/home/kash/linux/2.4.9-ac7/drivers/scsi/dpt_i2o.c:1962:adpt_ioctl: ERROR:RANGE:1962:1962: Using user length "id" as argument to "adpt_find_device" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':1962 [distance=1]

		if (copy_from_user((void*)&busy, (void*)arg, sizeof(TARGET_BUSY_T))) {
			return -EFAULT;
		}


Error --->
		d = adpt_find_device(pHba, busy.channel, busy.id, busy.lun);
---------------------------------------------------------
[BUG] looks valid.  copied in on line 721
/home/kash/linux/2.4.9-ac7/drivers/md/lvm.c:2205:__extend_reduce: ERROR:RANGE:2205:2205: [LOOP] Looping on user length "lv_allocated_le" set by 'inferred by call to copy_from_user, line 2183':2205 [distance=11]
                        }
                }
        }

        /* extend the PE count in PVs */

Error --->
        for (l = 0; l < new_lv->lv_allocated_le; l++) {
---------------------------------------------------------
[BUG] looks valid.  copied in on line 721
/home/kash/linux/2.4.9-ac7/drivers/md/lvm.c:2234:__extend_reduce: ERROR:RANGE:2231:2234: [LOOP] Looping on user length "lv_stripes" set by 'inferred by call to copy_from_user, line 2183':2231 [distance=13]

        } else {                /* striped logical volume */
                uint i, j, source, dest, end, old_stripe_size, new_stripe_size;

                old_stripe_size = old_lv->lv_allocated_le / old_lv->lv_stripes;
Start --->
                new_stripe_size = new_lv->lv_allocated_le / new_lv->lv_stripes;
                end = min(old_stripe_size, new_stripe_size);

Error --->
                for (i = source = dest = 0;
                     i < new_lv->lv_stripes; i++) {
                        for (j = 0; j < end; j++) {
                                new_lv->lv_current_pe[dest + j].reads +=
---------------------------------------------------------
[BUG]
/home/kash/linux/2.4.9-ac7/drivers/scsi/dpt_i2o.c:1694:adpt_i2o_passthru: ERROR:RANGE:1687:1694: Using user length "p" as argument to "virt_to_phys" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':1687 [distance=14]
			}
			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
			/* Copy in the user's SG buffer if necessary */
			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
				// TODO 64bit fix
Start --->
				if (copy_from_user((void*)p,(void*)sg[i].addr_bus, sg_size)) {
					printk(KERN_DEBUG"%s: Could not copy SG buf %d FROM user\n",pHba->name,i);
					rcode = -EFAULT;
					goto cleanup;
				}
			}
			//TODO 64bit fix
Error --->
			sg[i].addr_bus = (u32)virt_to_bus((void*)p);
		}
	}

---------------------------------------------------------
[BUG] only implicit check
/home/kash/linux/2.4.9-ac7/drivers/media/video/stradis.c:1480:saa_ioctl: ERROR:RANGE:1458:1480: Using user length "clipcount" as argument to "make_clip_tab" [type=GLOBAL] [state = need_lb] set by 'copy_from_user':1458 [distance=26]
			saa7146_set_winsize(saa);

			/*
			 *    Do any clips.
			 */
Start --->
			if (vw.clipcount < 0) {

	... DELETED 16 lines ...

					vfree(vcp);
					goto out;
				}
			} else	/* nothing clipped */
				memset(saa->dmavid2, 0, VIDEO_CLIPMAP_SIZE);
Error --->
			make_clip_tab(saa, vcp, vw.clipcount);
			if (vw.clipcount > 0)
				vfree(vcp);

---------------------------------------------------------
[BUG] no bounds check
/home/kash/linux/2.4.9-ac7/drivers/usb/ov511.c:2483:ov511_ioctl: ERROR:RANGE:2464:2483: Using user length "frame" as an array indexfor "frame" [state = need_ub] set by 'copy_from_user':2464 [distance=46]

		if (copy_from_user((void *)&vm, (void *)arg, sizeof(vm)))
			return -EFAULT;

		PDEBUG(4, "CMCAPTURE");
Start --->
		PDEBUG(4, "frame: %d, size: %dx%d, format: %d",

	... DELETED 13 lines ...

		if (vm.width > ov511->maxwidth || vm.height > ov511->maxheight) {
			err("VIDIOCMCAPTURE: requested dimensions too big");
			return -EINVAL;
		}

Error --->
		if (ov511->frame[vm.frame].grabstate == FRAME_GRABBING)
			return -EBUSY;

		/* Don't compress if the size changed */
---------------------------------------------------------
[BUG] VG_CHR does nothing
/home/kash/linux/2.4.9-ac7/drivers/md/lvm.c:1445:lvm_do_vg_create: ERROR:RANGE:1442:1445: Using user length "minor" as an array indexfor "vg" [state = need_ub] set by 'copy_from_user':1442 [linkages -> 1442:minor=vg_number -> 1442:vg_ptr->vg_number -> 1442:vg_ptr:start] [distance=2]
		kfree(vg_ptr);
		return -EFAULT;
	}

        /* VG_CREATE now uses minor number in VG structure */
Start --->
        if (minor == -1) minor = vg_ptr->vg_number;

	/* Validate it */
Error --->
        if (vg[VG_CHR(minor)] != NULL) {
		P_IOCTL("lvm_do_vg_create ERROR: VG %d in use\n", minor);
		kfree(vg_ptr);
  	     	return -EPERM;


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG] implicit check only
/home/kash/linux/2.4.9/drivers/net/wan/sdla.c:1201:sdla_xfer: ERROR:RANGE:1201:1201: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1201 [distance=1]
	if(copy_from_user(&mem, info, sizeof(mem)))
		return -EFAULT;

	if (read)
	{

Error --->
		temp = kmalloc(mem.len, GFP_KERNEL);
---------------------------------------------------------
[BUG] not completely sure, because we infer that erq->pointer comes from the user and erq->length may or may not come from the user.  If it does come from the user (and I think it does because there is bounds checking on it later), there is potential for a buffer overrun. (gem)
/home/kash/linux/2.4.9/drivers/net/wireless/orinoco.c:1945:dldwd_ioctl_setiwencode: ERROR:RANGE:1945:1945: Using user length "length" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'inferred by call to copy_from_user, line 1945':1945 [distance=1]
	char keybuf[MAX_KEY_SIZE];

	if (erq->pointer) {
		/* We actually have a key to set */


Error --->
		if (copy_from_user(keybuf, erq->pointer, erq->length))
---------------------------------------------------------
[BUG] no check at all
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:392:ioctl_parms: ERROR:RANGE:392:392: Using user length "oplen" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':392 [distance=1]

	c = i2o_find_controller(kcmd.iop);
	if(!c)
		return -ENXIO;


Error --->
	ops = (u8*)kmalloc(kcmd.oplen, GFP_KERNEL);
---------------------------------------------------------
[BUG] no check either way
/home/kash/linux/2.4.9/drivers/net/wan/lmc/lmc_main.c:503:lmc_ioctl: ERROR:RANGE:503:503: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':503 [distance=1]
                    if(xc.data == 0x0){
                            ret = -EINVAL;
                            break;
                    }


Error --->
                    data = kmalloc(xc.len, GFP_KERNEL);
---------------------------------------------------------
[BUG]  dataxferlen is never checked.
/home/kash/linux/2.4.9/drivers/scsi/megaraid.c:4722:megadev_ioctl: ERROR:RANGE:4722:4722: Using user length "dataxferlen" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':4722 [distance=1]
			ioc.data = kvaddr;

			if (inlen) {
				if (ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU) {
					/* copyin the user data */

Error --->
					copy_from_user (kvaddr, uaddr, ioc.pthru.dataxferlen);
---------------------------------------------------------
[BUG] kmalloc implicitly checks mem.len, but probably not the best
/home/kash/linux/2.4.9/drivers/net/wan/sdla.c:1214:sdla_xfer: ERROR:RANGE:1214:1214: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1214 [distance=1]
		}
		kfree(temp);
	}
	else
	{

Error --->
		temp = kmalloc(mem.len, GFP_KERNEL);
---------------------------------------------------------
[BUG] this one looks nasty.  not only copy a large amount but copy it wherever (gem)
/home/kash/linux/2.4.9/drivers/net/wan/farsync.c:1214:fst_ioctl: ERROR:RANGE:1203:1214: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1203 [distance=12]
                }

                /* Sanity check the parameters. We don't support partial writes
                 * when going over the top
                 */
Start --->
                if ( wrthdr.size + wrthdr.offset > FST_MEMSIZE )
                {
                        return -ENXIO;
                }

                /* Now copy the data to the card.
                 * This will probably break on some architectures.
                 * I'll fix it when I have something to test on.
                 */
                if ( copy_from_user ( card->mem + wrthdr.offset,
                                ifr->ifr_data + sizeof ( struct fstioc_write ),
Error --->
                                wrthdr.size ))
                {
                        return -EFAULT;
                }
---------------------------------------------------------
[BUG] only checks that kcmd.qlen is non-zero
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:476:ioctl_html: ERROR:RANGE:474:476: Using user length "qlen" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':474 [distance=12]

	c = i2o_find_controller(kcmd.iop);
	if(!c)
		return -ENXIO;

Start --->
	if(kcmd.qlen) /* Check for post data */
	{
Error --->
		query = kmalloc(kcmd.qlen, GFP_KERNEL);
		if(!query)
		{
			i2o_unlock_controller(c);
---------------------------------------------------------
[BUG] doesn't check cmd.length.
/home/kash/linux/2.4.9/drivers/net/wan/sdla_fr.c:1157:wpf_exec: ERROR:RANGE:1156:1157: Using user length "length" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1156 [distance=12]
	/* execute command */
	do
	{
		memcpy(&mbox->cmd, &cmd, sizeof(cmd));

Start --->
		if (cmd.length){
Error --->
			if( copy_from_user((void*)&mbox->data, u_data, cmd.length))
				return -EFAULT;
		}

---------------------------------------------------------
[BUG] MINOR checked indirectly.
/home/kash/linux/2.4.9/net/ipv6/netfilter/ip6_tables.c:1111:do_replace: ERROR:RANGE:1106:1111: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1106 [distance=13]

	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
		return -EFAULT;

	newinfo = vmalloc(sizeof(struct ip6t_table_info)
Start --->
			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
	if (!newinfo)
		return -ENOMEM;

	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
Error --->
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}
---------------------------------------------------------
[BUG] not sure: the obvious problem is that vmalloc will indirectly check
      since it will fail if tmp.size is too large.  However, the SMP_ALIGN
      may allow a way to crunch it down.
/home/kash/linux/2.4.9/net/ipv4/netfilter/ip_tables.c:1068:do_replace: ERROR:RANGE:1059:1068: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1059 [distance=24]

	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
		return -EFAULT;

	/* Hack: Causes ipchains to give correct error msg --RR */
Start --->
	if (len != sizeof(tmp) + tmp.size)
		return -ENOPROTOOPT;

	newinfo = vmalloc(sizeof(struct ipt_table_info)
			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
	if (!newinfo)
		return -ENOMEM;

	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
Error --->
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}
---------------------------------------------------------
[BUG]  i think so.  there is a check (dump.offset + dump.length >
card->hw.memory)) that can be fooled with well chosen offset values.

/home/kash/linux/2.4.9/drivers/net/wan/sdlamain.c:1034:ioctl_dump: ERROR:RANGE:982:1034: Using user length "length" as argument to "copy_to_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':982 [distance=25]
                return -EFAULT;
        memcpy_fromfs((void*)&dump, (void*)u_dump, sizeof(sdla_dump_t));
      #endif

	if ((dump.magic != WANPIPE_MAGIC) ||
Start --->
	    (dump.offset + dump.length > card->hw.memory))

	... DELETED 46 lines ...


	}else {

	     #if defined(LINUX_2_1) || defined(LINUX_2_4)
               if(copy_to_user((void *)dump.ptr,
Error --->
			       (u8 *)card->hw.dpmbase + dump.offset, dump.length)){
			return -EFAULT;
		}
             #else
---------------------------------------------------------
[BUG] upper bound check doesn't do anything since buf_size can never be that big
/home/kash/linux/2.4.9/drivers/block/cciss.c:606:cciss_ioctl: ERROR:RANGE:597:606: Using user length "buf_size" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':597 [distance=43]
		if (!capable(CAP_SYS_RAWIO)) return -EPERM;

		if (copy_from_user(&iocommand, (void *) arg, sizeof( IOCTL_Command_struct) ))
			return -EFAULT;
		if((iocommand.buf_size < 1) &&
Start --->
				(iocommand.Request.Type.Direction != XFER_NONE))
		{
			return -EINVAL;
		}
		/* Check kmalloc limits */
		if(iocommand.buf_size > 128000)
			return -EINVAL;
		if(iocommand.buf_size > 0)
		{
Error --->
			buff =  kmalloc(iocommand.buf_size, GFP_KERNEL);
			if( buff == NULL)
				return -EFAULT;
		}
---------------------------------------------------------
[BUG] upper bound check doesn't do anything because buf_size can never be that big
/home/kash/linux/2.4.9/drivers/block/cciss.c:613:cciss_ioctl: ERROR:RANGE:597:613: Using user length "buf_size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':597 [distance=54]
		if (!capable(CAP_SYS_RAWIO)) return -EPERM;

		if (copy_from_user(&iocommand, (void *) arg, sizeof( IOCTL_Command_struct) ))
			return -EFAULT;
		if((iocommand.buf_size < 1) &&
Start --->
				(iocommand.Request.Type.Direction != XFER_NONE))

	... DELETED 10 lines ...

				return -EFAULT;
		}
		if (iocommand.Request.Type.Direction == XFER_WRITE)
		{
			/* Copy the data into the buffer we created */
Error --->
			if (copy_from_user(buff, iocommand.buf, iocommand.buf_size))
			{
				kfree(buff);
				return -EFAULT;
---------------------------------------------------------
[BUG] upper bound check doesn't do anything because buf_size can never be that big
/home/kash/linux/2.4.9/drivers/block/cciss.c:683:cciss_ioctl: ERROR:RANGE:597:683: Using user length "buf_size" as argument to "copy_to_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':597 [distance=159]
		if (!capable(CAP_SYS_RAWIO)) return -EPERM;

		if (copy_from_user(&iocommand, (void *) arg, sizeof( IOCTL_Command_struct) ))
			return -EFAULT;
		if((iocommand.buf_size < 1) &&
Start --->
				(iocommand.Request.Type.Direction != XFER_NONE))

	... DELETED 80 lines ...

		}

		if (iocommand.Request.Type.Direction == XFER_READ)
                {
                        /* Copy the data out of the buffer we created */
Error --->
                        if (copy_to_user(iocommand.buf, buff, iocommand.buf_size))
			{
                        	kfree(buff);
				cmd_free(h, c, 0);
---------------------------------------------------------
[BUG] looks like you can stomp on kernel memory with this one
/home/kash/linux/2.4.9/net/bluetooth/hci_core.c:1836:hci_inquiry: ERROR:RANGE:1836:1836: Using user length "(null)" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1836 [linkages -> 1836:ir->num_rsp -> 1836:ir:start] [distance=1]
		goto done;

	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
	 * copy it to the user space.
	 */

Error --->
	if (!(buf = kmalloc(sizeof(inquiry_info) * ir.num_rsp, GFP_KERNEL))) {
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/net/ipv6/netfilter/ip6_tables.c:1116:do_replace: ERROR:RANGE:1116:1116: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1116 [linkages -> 1116:tmp->num_counters -> 1116:tmp:start] [distance=1]
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}


Error --->
	counters = vmalloc(tmp.num_counters * sizeof(struct ip6t_counters));
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/net/ipv4/netfilter/ip_tables.c:1073:do_replace: ERROR:RANGE:1073:1073: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1073 [linkages -> 1073:tmp->num_counters -> 1073:tmp:start] [distance=1]
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}


Error --->
	counters = vmalloc(tmp.num_counters * sizeof(struct ipt_counters));
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/net/irda/af_irda.c:2064:irda_getsockopt: ERROR:RANGE:2063:2064: Using user length "(null)" as argument to "copy_to_user" [type=LOCAL] [state = tainted] set by 'get_user':2064 [linkages -> 2063:len:start] [distance=3]
			sizeof(struct irda_device_info);

		/* Copy the list itself */
		total = offset + (list.len * sizeof(struct irda_device_info));
		if (total > len)
Start --->
			total = len;
Error --->
		if (copy_to_user(optval+offset, discoveries, total - offset))
			err = -EFAULT;

		/* Write total number of bytes used back to client */
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/i2c/i2c-dev.c:235:i2cdev_ioctl: ERROR:RANGE:230:235: Using user length "(null)" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':235 [linkages -> 230:rdwr_arg:start] [distance=12]
		if (copy_from_user(&rdwr_arg,
				   (struct i2c_rdwr_ioctl_data *)arg,
				   sizeof(rdwr_arg)))
			return -EFAULT;

Start --->
		if(rdwr_arg.nmsgs > 2048)
			return -EINVAL;

		rdwr_pa = (struct i2c_msg *)
			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
Error --->
			GFP_KERNEL);

		if (rdwr_pa == NULL) return -ENOMEM;

---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/block/DAC960.c:5363:DAC960_UserIOCTL: ERROR:RANGE:5360:5363: Using user length "DataTransferLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':5360 [linkages -> 5360:DataTransferLength=DataTransferLength -> 5360:UserCommand->DataTransferLength -> 5360:UserCommand:start] [distance=13]
	    ControllerNumber > DAC960_ControllerCount - 1)
	  return -ENXIO;
	Controller = DAC960_Controllers[ControllerNumber];
	if (Controller == NULL) return -ENXIO;
	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
Start --->
	DataTransferLength = UserCommand.DataTransferLength;
	if (DataTransferLength > 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
---------------------------------------------------------
[BUG] no upper check
/home/kash/linux/2.4.9/drivers/cdrom/sbpcd.c:4277:sbpcd_dev_ioctl: ERROR:RANGE:4273:4277: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'inferred by call to copy_from_user, line 4310':4277 [linkages -> 4273:arg:start] [distance=13]

	case CDROMAUDIOBUFSIZ: /* configure the audio buffer size */
		msg(DBG_IOC,"ioctl: CDROMAUDIOBUFSIZ entered.\n");
		if (D_S[d].sbp_audsiz>0) vfree(D_S[d].aud_buf);
		D_S[d].aud_buf=NULL;
Start --->
		D_S[d].sbp_audsiz=arg;

		if (D_S[d].sbp_audsiz>0)
		{
Error --->
			D_S[d].aud_buf=(u_char *) vmalloc(D_S[d].sbp_audsiz*CD_FRAMESIZE_RAW);
			if (D_S[d].aud_buf==NULL)
			{
				msg(DBG_INF,"audio buffer (%d frames) not available.\n",D_S[d].sbp_audsiz);
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/block/DAC960.c:5379:DAC960_UserIOCTL: ERROR:RANGE:5376:5379: Using user length "RequestSenseLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':5376 [linkages -> 5376:RequestSenseLength=RequestSenseLength -> 5376:UserCommand->RequestSenseLength -> 5376:UserCommand:start] [distance=13]
	    ErrorCode = copy_from_user(DataTransferBuffer,
				       UserCommand.DataTransferBuffer,
				       -DataTransferLength);
	    if (ErrorCode != 0) goto Failure2;
	  }
Start --->
	RequestSenseLength = UserCommand.RequestSenseLength;
	if (RequestSenseLength > 0)
	  {
Error --->
	    RequestSenseBuffer = kmalloc(RequestSenseLength, GFP_KERNEL);
	    if (RequestSenseBuffer == NULL)
	      {
		ErrorCode = -ENOMEM;
---------------------------------------------------------
[BUG] the malloc can be overflowed
/home/kash/linux/2.4.9/net/bluetooth/hci_core.c:1736:hci_dev_list: ERROR:RANGE:1731:1736: Using user length "size" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'get_user':1731 [linkages -> 1731:size=(null) -> 1731:dev_num op (null) -> 1731:dev_num:start] [distance=13]
	__u16 dev_num;

	if (get_user(dev_num, (__u16 *) arg))
		return -EFAULT;

Start --->
	size = dev_num * sizeof(struct hci_dev_req) + sizeof(__u16);

	if (verify_area(VERIFY_WRITE, (void *) arg, size))
		return -EFAULT;

Error --->
	if (!(dl = kmalloc(size, GFP_KERNEL)))
		return -ENOMEM;
	dr = dl->dev_req;

---------------------------------------------------------
[BUG] no upper bounds check
/home/kash/linux/2.4.9/drivers/net/ppp_generic.c:642:ppp_ioctl: ERROR:RANGE:639:642: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':641 [linkages -> 641:len=(null) -> 641:len op (null) -> 639:uprog:start] [distance=14]
		struct sock_filter *code = NULL;
		int len;

		if (copy_from_user(&uprog, (void *) arg, sizeof(uprog)))
			break;
Start --->
		if (uprog.len > 0) {
			err = -ENOMEM;
			len = uprog.len * sizeof(struct sock_filter);
Error --->
			code = kmalloc(len, GFP_KERNEL);
			if (code == 0)
				break;
			err = -EFAULT;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/block/DAC960.c:5369:DAC960_UserIOCTL: ERROR:RANGE:5360:5369: Using user length "(null)" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':5369 [linkages -> 5360:UserCommand->DataTransferLength -> 5360:UserCommand:start] [distance=24]
	    ControllerNumber > DAC960_ControllerCount - 1)
	  return -ENXIO;
	Controller = DAC960_Controllers[ControllerNumber];
	if (Controller == NULL) return -ENXIO;
	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
Start --->
	DataTransferLength = UserCommand.DataTransferLength;
	if (DataTransferLength > 0)
	  {
	    DataTransferBuffer = kmalloc(DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
	else if (DataTransferLength < 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(-DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    ErrorCode = copy_from_user(DataTransferBuffer,
				       UserCommand.DataTransferBuffer,
---------------------------------------------------------
[BUG] same as above
/home/kash/linux/2.4.9/fs/ncpfs/ioctl.c:394:ncp_ioctl: ERROR:RANGE:387:394: Using user length "outl" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] set by 'copy_from_user':387 [linkages -> 387:outl=object_name_len -> 387:user->object_name_len -> 387:user:start] [distance=26]

			if (copy_from_user(&user,
					   (struct ncp_objectname_ioctl*)arg,
					   sizeof(user))) return -EFAULT;
			user.auth_type = server->auth.auth_type;
Start --->
			outl = user.object_name_len;
			user.object_name_len = server->auth.object_name_len;
			if (outl > user.object_name_len)
				outl = user.object_name_len;
			if (outl) {
				if (copy_to_user(user.object_name,
						 server->auth.object_name,
Error --->
						 outl)) return -EFAULT;
			}
			if (copy_to_user((struct ncp_objectname_ioctl*)arg,
					 &user,
---------------------------------------------------------
[BUG] make user.len large enough so that outl becomes negative.  outl will then be < server->priv.len and make it past the check (gem)
/home/kash/linux/2.4.9/fs/ncpfs/ioctl.c:462:ncp_ioctl: ERROR:RANGE:456:462: Using user length "outl" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] set by 'copy_from_user':456 [linkages -> 456:outl=len -> 456:user->len -> 456:user:start] [distance=26]
			int outl;

			if (copy_from_user(&user,
					   (struct ncp_privatedata_ioctl*)arg,
					   sizeof(user))) return -EFAULT;
Start --->
			outl = user.len;
			user.len = server->priv.len;
			if (outl > user.len) outl = user.len;
			if (outl) {
				if (copy_to_user(user.data,
						 server->priv.data,
Error --->
						 outl)) return -EFAULT;
			}
			if (copy_to_user((struct ncp_privatedata_ioctl*)arg,
					 &user,
---------------------------------------------------------
[BUG] access_ok doesn't do enough of a check
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:649:ioctl_swul: ERROR:RANGE:640:649: Using user length "fragsize" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'get_user':640 [linkages -> 640:fragsize=(null) -> 640:swlen op (null) -> 640:swlen:start] [distance=35]
		return -EFAULT;

	if(get_user(curfrag, kxfer.curfrag) < 0)
		return -EFAULT;

Start --->
	if(curfrag==maxfrag) fragsize = swlen-(maxfrag-1)*8192;

	if(!kxfer.buf || !access_ok(VERIFY_WRITE, kxfer.buf, fragsize))
		return -EFAULT;

	c = i2o_find_controller(kxfer.iop);
	if(!c)
		return -ENXIO;

Error --->
	buffer=kmalloc(fragsize, GFP_KERNEL);
	if (buffer==NULL)
	{
		i2o_unlock_controller(c);
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/block/DAC960.c:5258:DAC960_UserIOCTL: ERROR:RANGE:5234:5258: Using user length "DataTransferLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':5234 [linkages -> 5234:DataTransferLength=DataTransferLength -> 5234:UserCommand->DataTransferLength -> 5234:UserCommand:start] [distance=35]
	  return -ENXIO;
	Controller = DAC960_Controllers[ControllerNumber];
	if (Controller == NULL) return -ENXIO;
	if (Controller->FirmwareType != DAC960_V1_Controller) return -EINVAL;
	CommandOpcode = UserCommand.CommandMailbox.Common.CommandOpcode;
Start --->
	DataTransferLength = UserCommand.DataTransferLength;

	... DELETED 18 lines ...

		!= abs(DataTransferLength))
	      return -EINVAL;
	  }
	if (DataTransferLength > 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
---------------------------------------------------------
[BUG] access_ok doesn't do enough of a check
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:581:ioctl_swdl: ERROR:RANGE:572:581: Using user length "fragsize" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'get_user':572 [linkages -> 572:fragsize=(null) -> 572:swlen op (null) -> 572:swlen:start] [distance=35]
		return -EFAULT;

	if(get_user(curfrag, kxfer.curfrag) < 0)
		return -EFAULT;

Start --->
	if(curfrag==maxfrag) fragsize = swlen-(maxfrag-1)*8192;

	if(!kxfer.buf || !access_ok(VERIFY_READ, kxfer.buf, fragsize))
		return -EFAULT;

	c = i2o_find_controller(kxfer.iop);
	if(!c)
		return -ENXIO;

Error --->
	buffer=kmalloc(fragsize, GFP_KERNEL);
	if (buffer==NULL)
	{
		i2o_unlock_controller(c);
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/isdn/act2000/capi.c:718:actcapi_dispatch: ERROR:RANGE:653:718: Using user length "(null)" as argument to "memcpy" [type=LOCAL] [state = tainted] set by 'network struct':718 [linkages -> 718:msg->len -> 653:data:start] [distance=37]
	isdn_ctrl cmd;
	char tmp[170];

	while ((skb = skb_dequeue(&card->rcvq))) {
		actcapi_debug_msg(skb, 0);
Start --->
		msg = (actcapi_msg *)skb->data;

	... DELETED 59 lines ...

						cmd.parm.setup.eazmsn[0] = msg->msg.connect_ind.eaz;
						cmd.parm.setup.eazmsn[1] = 0;
					}
					memset(cmd.parm.setup.phone, 0, sizeof(cmd.parm.setup.phone));
					memcpy(cmd.parm.setup.phone, msg->msg.connect_ind.addr.num,
Error --->
					       msg->msg.connect_ind.addr.len - 1);
					cmd.parm.setup.plan = msg->msg.connect_ind.addr.tnp;
					cmd.parm.setup.screen = 0;
					if (card->interface.statcallb(&cmd) == 2)
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.9/drivers/block/DAC960.c:5264:DAC960_UserIOCTL: ERROR:RANGE:5234:5264: Using user length "(null)" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':5264 [linkages -> 5234:UserCommand->DataTransferLength -> 5234:UserCommand:start] [distance=46]
	  return -ENXIO;
	Controller = DAC960_Controllers[ControllerNumber];
	if (Controller == NULL) return -ENXIO;
	if (Controller->FirmwareType != DAC960_V1_Controller) return -EINVAL;
	CommandOpcode = UserCommand.CommandMailbox.Common.CommandOpcode;
Start --->
	DataTransferLength = UserCommand.DataTransferLength;

	... DELETED 24 lines ...

	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
	else if (DataTransferLength < 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(-DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    ErrorCode = copy_from_user(DataTransferBuffer,
				       UserCommand.DataTransferBuffer,
---------------------------------------------------------
[BUG] no bounds checking for default case of switch statement
/home/kash/linux/2.4.9/drivers/usb/devio.c:857:proc_submiturb: ERROR:RANGE:796:857: Using user length "buffer_length" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':806 [linkages -> 806:buffer_length=(null) -> 796:(null) op (null) -> 796:(null):start] [distance=50]
			return -ENOMEM;
		if (copy_from_user(dr, (unsigned char*)uurb.buffer, 8)) {
			kfree(dr);
			return -EFAULT;
		}
Start --->
		if (uurb.buffer_length < (le16_to_cpup(&dr->length) + 8)) {

	... DELETED 55 lines ...

			kfree(isopkt);
		if (dr)
			kfree(dr);
		return -ENOMEM;
	}
Error --->
	if (!(as->urb.transfer_buffer = kmalloc(uurb.buffer_length, GFP_KERNEL))) {
		if (isopkt)
			kfree(isopkt);
		if (dr)
---------------------------------------------------------
[BUG] do they really want to alloc a chunk of memory < INT_MAX?  kmalloc is going to fail at 128k.  this seems wrong
/home/kash/linux/2.4.9/net/socket.c:1406:sys_sendmsg: ERROR:RANGE:1394:1406: Using user length "ctl_len" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1396 [linkages -> 1396:ctl_len=msg_controllen -> 1394:msg_sys:start] [distance=51]
		goto out_freeiov;
	total_len = err;

	err = -ENOBUFS;

Start --->
	if (msg_sys.msg_controllen > INT_MAX)
		goto out_freeiov;
	ctl_len = msg_sys.msg_controllen;
	if (ctl_len)
	{
		if (ctl_len > sizeof(ctl))
		{
			ctl_buf = sock_kmalloc(sock->sk, ctl_len, GFP_KERNEL);
			if (ctl_buf == NULL)
				goto out_freeiov;
		}
		err = -EFAULT;
Error --->
		if (copy_from_user(ctl_buf, msg_sys.msg_control, ctl_len))
			goto out_freectl;
		msg_sys.msg_control = ctl_buf;
	}
---------------------------------------------------------
[BUG] minor. no check on clipcount
/home/kash/linux/2.4.9/drivers/media/video/zr36067.c:3761:do_zoran_ioctl: ERROR:RANGE:3737:3761: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':3761 [linkages -> 3737:vw:start] [distance=59]
			zr->window.width = vw.width;
			zr->window.height = vw.height;
			zr->window.chromakey = 0;
			zr->window.flags = 0;	// RJ: Is this intended for interlace on/off ?
			zr->window.clips = NULL;
Start --->
			zr->window.clipcount = vw.clipcount;

	... DELETED 18 lines ...

			if (vw.clipcount > 2048)
				return -EINVAL;
			if (vw.clipcount) {
				vcp =
				    vmalloc(sizeof(struct video_clip) *
Error --->
					    (vw.clipcount + 4));
				if (vcp == NULL) {
					printk(KERN_ERR
					       "%s: zoran_ioctl: Alloc of clip mask failed\n",
---------------------------------------------------------
[BUG] no bounds check
/home/kash/linux/2.4.9/drivers/media/video/zr36067.c:3771:do_zoran_ioctl: ERROR:RANGE:3737:3771: Using user length "(null)" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':3771 [linkages -> 3737:vw:start] [distance=71]
			zr->window.width = vw.width;
			zr->window.height = vw.height;
			zr->window.chromakey = 0;
			zr->window.flags = 0;	// RJ: Is this intended for interlace on/off ?
			zr->window.clips = NULL;
Start --->
			zr->window.clipcount = vw.clipcount;

	... DELETED 28 lines ...

					return -ENOMEM;
				}
				if (copy_from_user
				    (vcp, vw.clips,
				     sizeof(struct video_clip) *
Error --->
				     vw.clipcount)) {
					vfree(vcp);
					return -EFAULT;
				}
---------------------------------------------------------
[BUG] tex gets copied in on line 1365.  there are a number of paths to get to this error (gem)
/home/kash/linux/2.4.9/drivers/char/drm/radeon_state.c:1104:radeon_cp_dispatch_texture: ERROR:RANGE:1007:1104: Using user length "tex_width" as argument to "copy_from_user" [type=LOCAL] [state = need_lb] set by 'inferred by call to copy_to_user, line 1057':1007 [linkages -> 1007:tex_width=(null) -> 1007:width op (null) -> 1007:tex->width -> 1007:tex:start] [distance=252]
	case RADEON_TXFORMAT_AI88:
	case RADEON_TXFORMAT_ARGB1555:
	case RADEON_TXFORMAT_RGB565:
	case RADEON_TXFORMAT_ARGB4444:
		format = RADEON_COLOR_FORMAT_RGB565;
Start --->
		tex_width = tex->width * 2;

	... DELETED 91 lines ...

		/* Texture image width is less than the minimum, so we
		 * need to pad out each image scanline to the minimum
		 * width.
		 */
		for ( i = 0 ; i < tex->height ; i++ ) {
Error --->
			if ( copy_from_user( buffer, data, tex_width ) ) {
				DRM_ERROR( "EFAULT on pad, %d bytes\n",
					   tex_width );
				return -EFAULT;
---------------------------------------------------------
[BUG]
/home/kash/linux/2.4.9/drivers/md/lvm.c:2734:lvm_do_lv_status_byindex: ERROR:RANGE:2734:2734: Using user length "lv_index" as an array indexfor "lv" [state = need_ub] set by 'copy_from_user':2734 [distance=1]
			   sizeof(lv_status_byindex_req)) != 0)
		return -EFAULT;

	if ((lvp = lv_status_byindex_req.lv) == NULL)
		return -EINVAL;

Error --->
	if ( ( lv_ptr = vg_ptr->lv[lv_status_byindex_req.lv_index]) == NULL)
---------------------------------------------------------
[BUG] looks like it allocates memory without checking bounds but it is hard to tell because of function pointers.  it also loops on pg_count
/home/kash/linux/2.4.9/drivers/char/agp/agpgart_fe.c:928:agpioc_allocate_wrap: ERROR:RANGE:928:928: Using user length "pg_count" as argument to "agp_allocate_memory_wrap" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':928 [distance=1]
	agp_allocate alloc;

	if (copy_from_user(&alloc, (void *) arg, sizeof(agp_allocate))) {
		return -EFAULT;
	}

Error --->
	memory = agp_allocate_memory_wrap(alloc.pg_count, alloc.type);
---------------------------------------------------------
[BUG] minor if anything.  loops on count
/home/kash/linux/2.4.9/drivers/ide/ide-tape.c:5265:idetape_chrdev_ioctl: ERROR:RANGE:5265:5265: Using user length "mt_count" as argument to "idetape_mtioctop" [type=GLOBAL] [state = tainted] set by 'copy_from_user':5265 [distance=1]
	}
	switch (cmd) {
		case MTIOCTOP:
			if (copy_from_user ((char *) &mtop, (char *) arg, sizeof (struct mtop)))
				return -EFAULT;

Error --->
			return (idetape_mtioctop (drive,mtop.mt_op,mtop.mt_count));
---------------------------------------------------------
[BUG] minor.  stli_getport loops on panelnr but the loop is tight and the effect of the loop is checked before being used.  stli_getport gets called the same way in a number of other places
/home/kash/linux/2.4.9/drivers/char/istallion.c:5158:stli_getportstruct: ERROR:RANGE:5158:5158: Using user length "panelnr" as argument to "stli_getport" [type=GLOBAL] [state = tainted] set by 'copy_from_user':5158 [distance=1]
	stliport_t	*portp;

	if (copy_from_user(&stli_dummyport, (void *)arg, sizeof(stliport_t)))
		return -EFAULT;
	portp = stli_getport(stli_dummyport.brdnr, stli_dummyport.panelnr,

Error --->
		 stli_dummyport.portnr);
---------------------------------------------------------
[BUG] used as an array access
/home/kash/linux/2.4.9/drivers/char/moxa.c:1723:MoxaDriverIoctl: ERROR:RANGE:1723:1723: Using user length "cardno" as argument to "moxaloadbios" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1723 [distance=1]
			return -EFAULT;
		return (0);
	case MOXA_LOAD_BIOS:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
---------------------------------------------------------
[BUG] moxaloadbios does no checking
/home/kash/linux/2.4.9/drivers/char/moxa.c:1723:MoxaDriverIoctl: ERROR:RANGE:1723:1723: Using user length "len" as argument to "moxaloadbios" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1723 [distance=1]
			return -EFAULT;
		return (0);
	case MOXA_LOAD_BIOS:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
---------------------------------------------------------
[BUG] used as an array access
/home/kash/linux/2.4.9/drivers/char/moxa.c:1732:MoxaDriverIoctl: ERROR:RANGE:1732:1732: Using user length "cardno" as argument to "moxaload320b" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1732 [distance=1]
			return -EFAULT;
		return moxafindcard(dltmp.cardno);
	case MOXA_LOAD_C320B:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
---------------------------------------------------------
[BUG] there look to be a bunch of errors in this function
/home/kash/linux/2.4.9/drivers/char/moxa.c:1737:MoxaDriverIoctl: ERROR:RANGE:1737:1737: Using user length "len" as argument to "moxaloadcode" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1737 [distance=1]
		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
		return (0);
	case MOXA_LOAD_CODE:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		i = moxaloadcode(dltmp.cardno, dltmp.buf, dltmp.len);
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/char/isicom.c:229:ISILoad_ioctl: ERROR:RANGE:229:229: Using user length "addr" as argument to "outw" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':229 [distance=1]
			if (WaitTillCardIsFree(base))
				return -EIO;

			outw(0xf0,base);	/* start upload sequence */
			outw(0x00,base);

Error --->
			outw((frame.addr), base);/*      lsb of adderess    */
---------------------------------------------------------
[BUG] used as an array index
/home/kash/linux/2.4.9/drivers/char/moxa.c:1737:MoxaDriverIoctl: ERROR:RANGE:1737:1737: Using user length "cardno" as argument to "moxaloadcode" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1737 [distance=1]
		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
		return (0);
	case MOXA_LOAD_CODE:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		i = moxaloadcode(dltmp.cardno, dltmp.buf, dltmp.len);
---------------------------------------------------------
[BUG] used as an array access
/home/kash/linux/2.4.9/drivers/char/moxa.c:1728:MoxaDriverIoctl: ERROR:RANGE:1728:1728: Using user length "cardno" as argument to "moxafindcard" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1728 [distance=1]
		i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
		return (i);
	case MOXA_FIND_BOARD:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;

Error --->
		return moxafindcard(dltmp.cardno);
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/char/isicom.c:272:ISILoad_ioctl: ERROR:RANGE:272:272: Using user length "addr" as argument to "outw" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':272 [distance=1]
			if (WaitTillCardIsFree(base))
				return -EIO;

			outw(0xf1,base);	/* start download sequence */
			outw(0x00,base);

Error --->
			outw((frame.addr), base);/*      lsb of adderess    */
---------------------------------------------------------
[BUG] minor. allocs memory in fallback_on_noddma_alloc without checking bounds
/home/kash/linux/2.4.9/drivers/block/floppy.c:3235:raw_cmd_copyin: ERROR:RANGE:3235:3235: Using user length "length" as argument to "fd_copyin" [type=GLOBAL] [state = tainted] set by 'copy_from_user':3235 [distance=1]
				return -ENOMEM;
			ptr->buffer_length = ptr->length;
		}
		if (ptr->flags & FD_RAW_WRITE)
			ECALL(fd_copyin(ptr->data, ptr->kernel_data,

Error --->
					ptr->length));
---------------------------------------------------------
[BUG] there is bounds check on reg, but not on data
/home/kash/linux/2.4.9/drivers/net/hamradio/soundmodem/sm_sbc.c:602:sbc_ioctl: ERROR:RANGE:602:602: Using user length "data" as argument to "outb" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':602 [distance=1]
		if (bi.data.mix.reg >= 0x80)
			return -EACCES;
		save_flags(flags);
		cli();
		outb(bi.data.mix.reg, DSP_MIXER_ADDR(dev->base_addr));

Error --->
		outb(bi.data.mix.data, DSP_MIXER_DATA(dev->base_addr));
---------------------------------------------------------
[BUG] not completely sure that skb is on its way out.  it looks like one path might have it go in that direction.
/home/kash/linux/2.4.9/drivers/net/wan/lmc/lmc_main.c:2175:lmc_softreset: ERROR:RANGE:2170:2175: Using user length "data" as argument to "virt_to_phys" [type=GLOBAL] [state = tainted] set by 'network struct':2170 [distance=2]

        /* owned by 21140 */
        sc->lmc_rxring[i].status = 0x80000000;

        /* used to be PKT_BUF_SZ now uses skb since we loose some to head room */
Start --->
        sc->lmc_rxring[i].length = skb->end - skb->data;

        /* use to be tail which is dumb since you're thinking why write
         * to the end of the packj,et but since there's nothing there tail == data
         */
Error --->
        sc->lmc_rxring[i].buffer1 = virt_to_bus (skb->data);

        /* This is fair since the structure is static and we have the next address */
        sc->lmc_rxring[i].buffer2 = virt_to_bus (&sc->lmc_rxring[i + 1]);
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:598:ioctl_swdl: ERROR:RANGE:587:598: Using user length "buffer" as argument to "virt_to_phys" [type=GLOBAL] [state = need_ub] set by '__copy_from_user':587 [nbytes = 1]  [distance=10]
	if (buffer==NULL)
	{
		i2o_unlock_controller(c);
		return -ENOMEM;
	}
Start --->
	__copy_from_user(buffer, kxfer.buf, fragsize);

	msg[0]= NINE_WORD_MSG_SIZE | SGL_OFFSET_7;
	msg[1]= I2O_CMD_SW_DOWNLOAD<<24 | HOST_TID<<12 | ADAPTER_TID;
	msg[2]= (u32)cfg_handler.context;
	msg[3]= 0;
	msg[4]= (((u32)kxfer.flags)<<24) | (((u32)kxfer.sw_type)<<16) |
		(((u32)maxfrag)<<8) | (((u32)curfrag));
	msg[5]= swlen;
	msg[6]= kxfer.sw_id;
	msg[7]= (0xD0000000 | fragsize);
Error --->
	msg[8]= virt_to_bus(buffer);

//	printk("i2o_config: swdl frag %d/%d (size %d)\n", curfrag, maxfrag, fragsize);
	status = i2o_post_wait_mem(c, msg, sizeof(msg), 60, buffer, NULL);
---------------------------------------------------------
[BUG] loops on data_len
/home/kash/linux/2.4.9/drivers/isdn/tpam/tpam_commands.c:157:tpam_command_ioctl_dspload: ERROR:RANGE:151:157: Using user length "data_len" as argument to "copy_from_user_to_pam" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':151 [distance=12]
		return -EFAULT;

	/* if the board's firmware was started, protect against writes
	 * to unallowed memory areas. If the board's firmware wasn't started,
	 * all is allowed. */
Start --->
	if (card->running && tpam_verify_area(tdl.address, tdl.data_len))
		return -EPERM;

	/* write the data in the board's memory */
	ret = copy_from_user_to_pam(card, (void *)tdl.address,
				    (void *)arg + sizeof(tpam_dsp_ioctl),
Error --->
				    tdl.data_len);
	return 0;
}

---------------------------------------------------------
[BUG]
/home/kash/linux/2.4.9/drivers/isdn/tpam/tpam_commands.c:186:tpam_command_ioctl_dspsave: ERROR:RANGE:181:186: Using user length "data_len" as argument to "copy_from_pam_to_user" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':181 [distance=12]
	/* get the IOCTL parameter from userspace */
	if (copy_from_user(&tdl, (void *)arg, sizeof(tpam_dsp_ioctl)))
		return -EFAULT;

	/* protect against read from unallowed memory areas */
Start --->
	if (tpam_verify_area(tdl.address, tdl.data_len))
		return -EPERM;

	/* read the data from the board's memory */
	ret = copy_from_pam_to_user(card, (void *)arg + sizeof(tpam_dsp_ioctl),
Error --->
				    (void *)tdl.address, tdl.data_len);
	return ret;
}

---------------------------------------------------------
[BUG] long loop?
/home/kash/linux/2.4.9/drivers/char/sx.c:1710:sx_fw_ioctl: ERROR:RANGE:1709:1710: [LOOP] Looping on user length "data" set by 'get_user':1709 [distance=22]

		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
		if (!tmp) return -ENOMEM;
		Get_user (nbytes, descr++);
		Get_user (offset, descr++);
Start --->
		Get_user (data,	 descr++);
Error --->
		while (nbytes && data) {
			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
				copy_from_user (tmp, (char *)data+i,
				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
---------------------------------------------------------
[BUG] loops on len in readmem
/home/kash/linux/2.4.9/drivers/net/wan/cosa.c:1087:cosa_readmem: ERROR:RANGE:1081:1087: Using user length "len" as argument to "readmem" [type=GLOBAL] [state = tainted] set by '__get_user':1081 [distance=23]
		return -EPERM;
	}

	if (get_user(addr, &(d->addr)) ||
	    __get_user(len, &(d->len)) ||
Start --->
	    __get_user(code, &(d->code)))
		return -EFAULT;

	/* If something fails, force the user to reset the card */
	cosa->firmware_status &= ~COSA_FW_RESET;

Error --->
	if ((i=readmem(cosa, d->code, len, addr)) < 0) {
		printk(KERN_NOTICE "cosa%d: reading memory failed: %d\n",
			cosa->num, i);
		return -EIO;
---------------------------------------------------------
[BUG] array access
/home/kash/linux/2.4.9/drivers/media/video/zr36120.c:1112:zoran_ioctl: ERROR:RANGE:1102:1112: Using user length "tuner" as argument to "zoran_muxsel" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1102 [distance=23]
		if (copy_from_user(&v, arg, sizeof(v)))
			return -EFAULT;
		DEBUG(printk(CARD_DEBUG "VIDIOCSTUNER(%d,%d)\n",CARD,v.tuner,v.mode));

		/* Only no or one tuner for now */
Start --->
		if (!ztv->have_tuner || v.tuner)
			return -EINVAL;

		/* and it only has certain valid modes */
		if( v.mode != VIDEO_MODE_PAL &&
		    v.mode != VIDEO_MODE_NTSC &&
		    v.mode != VIDEO_MODE_SECAM)
			return -EOPNOTSUPP;

		/* engage! */
Error --->
		return zoran_muxsel(ztv,v.tuner,v.mode);
	 }

	 case VIDIOCGPICT:
---------------------------------------------------------
[BUG] channel is used as an array index
/home/kash/linux/2.4.9/drivers/media/video/zr36120.c:1069:zoran_ioctl: ERROR:RANGE:1059:1069: Using user length "channel" as argument to "zoran_muxsel" [type=GLOBAL] [state = need_lb] set by 'copy_from_user':1059 [distance=23]
		if (copy_from_user(&v, arg,sizeof(v)))
			return -EFAULT;
		DEBUG(printk(CARD_DEBUG "VIDIOCSCHAN(%d,%d)\n",CARD,v.channel,v.norm));

		/* too many inputs? no decoder -> no channels */
Start --->
		if (!ztv->have_decoder || v.channel >= ztv->card->video_inputs)
			return -EINVAL;

		if (v.norm != VIDEO_MODE_PAL &&
		    v.norm != VIDEO_MODE_NTSC &&
		    v.norm != VIDEO_MODE_SECAM &&
		    v.norm != VIDEO_MODE_AUTO)
			return -EOPNOTSUPP;

		/* make it happen, nr1! */
Error --->
		return zoran_muxsel(ztv,v.channel,v.norm);
	 }

	 case VIDIOCGTUNER:
---------------------------------------------------------
[BUG] big loop?
/home/kash/linux/2.4.9/drivers/char/sx.c:1710:sx_fw_ioctl: ERROR:RANGE:1707:1710: [LOOP] Looping on user length "nbytes" set by 'get_user':1707 [distance=24]
			return -EIO;
		sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");

		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
		if (!tmp) return -ENOMEM;
Start --->
		Get_user (nbytes, descr++);
		Get_user (offset, descr++);
		Get_user (data,	 descr++);
Error --->
		while (nbytes && data) {
			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
				copy_from_user (tmp, (char *)data+i,
				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
---------------------------------------------------------
[BUG] not sure
/home/kash/linux/2.4.9/drivers/sound/wavfront.c:1308:wavefront_send_sample: ERROR:RANGE:1269:1308: Using user length "sample_short" as argument to "outw" [type=GLOBAL] [state = need_ub] set by '__get_user':1269 [distance=27]

		for (i = 0; i < blocksize; i++) {

			if (dataptr < data_end) {

Start --->
				__get_user (sample_short, dataptr);

	... DELETED 33 lines ...

				   whatever the final value was.
				*/
			}

			if (i < blocksize - 1) {
Error --->
				outw (sample_short, dev.block_port);
			} else {
				outw (sample_short, dev.last_block_port);
			}
---------------------------------------------------------
[BUG] loop on entry_ct.
/home/kash/linux/2.4.9/drivers/char/vt.c:412:do_unimap_ioctl: ERROR:RANGE:405:412: Using user length "entry_ct" as argument to "con_set_unimap" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':405 [distance=28]

	if (copy_from_user(&tmp, user_ud, sizeof tmp))
		return -EFAULT;
	if (tmp.entries) {
		i = verify_area(VERIFY_WRITE, tmp.entries,
Start --->
						tmp.entry_ct*sizeof(struct unipair));
		if (i) return i;
	}
	switch (cmd) {
	case PIO_UNIMAP:
		if (!perm)
			return -EPERM;
Error --->
		return con_set_unimap(fg_console, tmp.entry_ct, tmp.entries);
	case GIO_UNIMAP:
		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
	}
---------------------------------------------------------
[BUG] big loop?
/home/kash/linux/2.4.9/drivers/char/tpqic02.c:2686:qic02_tape_ioctl: ERROR:RANGE:2654:2686: [LOOP] Looping on user length "mt_count" set by 'copy_from_user':2654 [distance=38]
	 * ---	    tape at the beginning of the current file.
	 */

	if (TP_DIAGS(current_tape_dev))
	{
Start --->
	    printk("OP op=%4x, count=%4x\n", operation.mt_op, operation.mt_count);

	... DELETED 26 lines ...


	    ioctl_status.mt_resid = 0;
	}
	else
	{
Error --->
	    while (operation.mt_count > 0)
	    {
		operation.mt_count--;
		if ((error = do_ioctl_cmd(operation.mt_op)) != 0)
---------------------------------------------------------
[BUG] minor. allocs memory in fallback_on_noddma_alloc without checking bounds
/home/kash/linux/2.4.9/drivers/block/floppy.c:3235:raw_cmd_copyin: ERROR:RANGE:3224:3235: Using user length "length" as argument to "fd_copyin" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':3224 [distance=39]
			ptr->reply[i] = 0;
		ptr->resultcode = 0;
		ptr->kernel_data = 0;

		if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
Start --->
			if (ptr->length <= 0)
				return -EINVAL;
			ptr->kernel_data =(char*)fd_dma_mem_alloc(ptr->length);
			fallback_on_nodma_alloc(&ptr->kernel_data,
						ptr->length);
			if (!ptr->kernel_data)
				return -ENOMEM;
			ptr->buffer_length = ptr->length;
		}
		if (ptr->flags & FD_RAW_WRITE)
			ECALL(fd_copyin(ptr->data, ptr->kernel_data,
Error --->
					ptr->length));
		rcmd = & (ptr->next);
		if (!(ptr->flags & FD_RAW_MORE))
			return 0;
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/i2o/i2o_config.c:512:ioctl_html: ERROR:RANGE:482:512: Using user length "query" as argument to "virt_to_phys" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':482 [nbytes = 0]  [distance=47]
		if(!query)
		{
			i2o_unlock_controller(c);
			return -ENOMEM;
		}
Start --->
		if(copy_from_user(query, kcmd.qbuf, kcmd.qlen))

	... DELETED 24 lines ...

	else
	{
		msg[0] = NINE_WORD_MSG_SIZE|SGL_OFFSET_5;
		msg[5] = 0x50000000|65536;
		msg[7] = 0xD4000000|(kcmd.qlen);
Error --->
		msg[8] = virt_to_bus(query);
	}
	/*
	Wait for a considerable time till the Controller
---------------------------------------------------------
[BUG] big loop
/home/kash/linux/2.4.9/drivers/isdn/hisax/isar.c:242:isar_load_firmware: ERROR:RANGE:220:242: [LOOP] Looping on user length "size" set by 'copy_from_user':220 [distance=59]
	printk(KERN_DEBUG"isar_load_firmware buf %#lx\n", (u_long)buf);
	if ((ret = verify_area(VERIFY_READ, (void *) p, sizeof(int)))) {
		printk(KERN_ERR"isar_load_firmware verify_area ret %d\n", ret);
		return ret;
	}
Start --->
	if ((ret = copy_from_user(&size, p, sizeof(int)))) {

	... DELETED 16 lines ...

	if (!(tmpmsg = kmalloc(256, GFP_KERNEL))) {
		printk(KERN_ERR"isar_load_firmware no tmp buffer\n");
		kfree(msg);
		return (1);
	}
Error --->
	while (cnt < size) {
		if ((ret = copy_from_user(&blk_head, p, BLK_HEAD_SIZE))) {
			printk(KERN_ERR"isar_load_firmware copy_from_user ret %d\n", ret);
			goto reterror;
---------------------------------------------------------
[BUG] I think this one could be bad.  the loop is inside of a lock and the malloc could be overflowed so that too much info is copied to the user on line 1753
/home/kash/linux/2.4.9/net/bluetooth/hci_core.c:1741:hci_dev_list: ERROR:RANGE:1728:1741: [LOOP] Looping on user length "dev_num" set by 'get_user':1728 [distance=67]
	struct hci_dev_req *dr;
	struct hci_dev *hdev;
	int i, n, size;
	__u16 dev_num;

Start --->
	if (get_user(dev_num, (__u16 *) arg))
		return -EFAULT;

	size = dev_num * sizeof(struct hci_dev_req) + sizeof(__u16);

	if (verify_area(VERIFY_WRITE, (void *) arg, size))
		return -EFAULT;

	if (!(dl = kmalloc(size, GFP_KERNEL)))
		return -ENOMEM;
	dr = dl->dev_req;

	spin_lock_bh(&hdev_list_lock);
Error --->
	for (i = 0, n = 0; i < HCI_MAX_DEV && n < dev_num; i++) {
		if ((hdev = hdev_list[i])) {
			(dr + n)->dev_id  = hdev->id;
			(dr + n)->dev_opt = hdev->flags;
---------------------------------------------------------
[BUG] not so sure about this one
/home/kash/linux/2.4.9/drivers/atm/nicstar.c:2387:dequeue_rx: ERROR:RANGE:2360:2387: Using user length "data" as argument to "virt_to_phys" [type=GLOBAL] [state = tainted] set by 'network struct':2360 [distance=68]

   if (ns_rsqe_eopdu(rsqe))
   {
      /* This works correctly regardless of the endianness of the host */
      unsigned char *L1L2 = (unsigned char *)((u32)skb->data +
Start --->
                                              iov->iov_len - 6);

	... DELETED 21 lines ...

      {
         /* skb points to a small buffer */
         if (!atm_charge(vcc, skb->truesize))
         {
            push_rxbufs(card, BUF_SM, (u32) skb, (u32) virt_to_bus(skb->data),
Error --->
                        0, 0);
         }
         else
	 {
---------------------------------------------------------
[BUG] looks very likely (gem)
/home/kash/linux/2.4.9/net/atm/common.c:719:atm_ioctl: ERROR:RANGE:794:719: [FN-PTR] Possibly using user length "arg" as argumentto "atm_mpoa_mpoad_attach" [type=GLOBAL] [state = tainted] set by 'inferred by call to copy_to_user, line 617':794
                                atm_mpoa_init();
			if (atm_mpoa_ops.mpoad_attach == NULL) { /* try again */
				ret_val = -ENOSYS;
				goto done;
			}
Error --->
			error = atm_mpoa_ops.mpoad_attach(vcc, (int)arg);

	... DELETED 69 lines ...

		ret_val = -ENODEV;
		goto done;
	}

	size = 0;
Start --->
	switch (cmd) {
		case ATM_GETTYPE:
			size = strlen(dev->type)+1;
			if (copy_to_user(buf,dev->type,size)) {
---------------------------------------------------------
[BUG] there look to be a number of problems with clipcount here.  one is that write_overlay_mask loops on that value, but there are other problems further up.
/home/kash/linux/2.4.9/drivers/media/video/zr36067.c:3775:do_zoran_ioctl: ERROR:RANGE:3737:3775: Using user length "clipcount" as argument to "write_overlay_mask" [type=GLOBAL] [state = need_lb] set by 'copy_from_user':3737 [distance=82]
			zr->window.width = vw.width;
			zr->window.height = vw.height;
			zr->window.chromakey = 0;
			zr->window.flags = 0;	// RJ: Is this intended for interlace on/off ?
			zr->window.clips = NULL;
Start --->
			zr->window.clipcount = vw.clipcount;

	... DELETED 32 lines ...

				     sizeof(struct video_clip) *
				     vw.clipcount)) {
					vfree(vcp);
					return -EFAULT;
				}
Error --->
				write_overlay_mask(zr, vcp, vw.clipcount);
				vfree(vcp);
			}

---------------------------------------------------------
[BUG] even the implementor agrees (gem)

		else
			return -EINVAL;
		/* FIXME: we need upper bound checking, too!! */
		if (lba < 0 || ra.nframes <= 0)
			return -EINVAL;
/home/kash/linux/2.4.9/drivers/cdrom/cdrom.c:2035:mmc_ioctl: ERROR:RANGE:2012:2035: [LOOP] Looping on user length "nframes" set by 'copy_from_user':2012 [distance=85]
			lba = ra.addr.lba;
		else
			return -EINVAL;

		/* FIXME: we need upper bound checking, too!! */
Start --->
		if (lba < 0 || ra.nframes <= 0)

	... DELETED 17 lines ...

		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
			kfree(cgc.buffer);
			return -EFAULT;
		}
		cgc.data_direction = CGC_DATA_READ;
Error --->
		while (ra.nframes > 0) {
			if (nr > ra.nframes)
				nr = ra.nframes;

---------------------------------------------------------
[BUG] not sure about this one
/home/kash/linux/2.4.9/drivers/atm/nicstar.c:2438:dequeue_rx: ERROR:RANGE:2360:2438: Using user length "data" as argument to "virt_to_phys" [type=GLOBAL] [state = tainted] set by 'network struct':2360 [distance=92]

   if (ns_rsqe_eopdu(rsqe))
   {
      /* This works correctly regardless of the endianness of the host */
      unsigned char *L1L2 = (unsigned char *)((u32)skb->data +
Start --->
                                              iov->iov_len - 6);

	... DELETED 72 lines ...

	 else			/* len > NS_SMBUFSIZE, the usual case */
	 {
            if (!atm_charge(vcc, skb->truesize))
            {
               push_rxbufs(card, BUF_LG, (u32) skb,
Error --->
                           (u32) virt_to_bus(skb->data), 0, 0);
            }
            else
            {
---------------------------------------------------------
[BUG] not so sure about this one
/home/kash/linux/2.4.9/drivers/atm/nicstar.c:2430:dequeue_rx: ERROR:RANGE:2360:2430: Using user length "data" as argument to "virt_to_phys" [type=GLOBAL] [state = tainted] set by 'network struct':2360 [distance=96]

   if (ns_rsqe_eopdu(rsqe))
   {
      /* This works correctly regardless of the endianness of the host */
      unsigned char *L1L2 = (unsigned char *)((u32)skb->data +
Start --->
                                              iov->iov_len - 6);

	... DELETED 64 lines ...

               vcc->push(vcc, sb);
               atomic_inc(&vcc->stats->rx);
            }

            push_rxbufs(card, BUF_LG, (u32) skb,
Error --->
	                   (u32) virt_to_bus(skb->data), 0, 0);

	 }
	 else			/* len > NS_SMBUFSIZE, the usual case */
---------------------------------------------------------
[BUG]  tex gets copied in on line 1365.
/home/kash/linux/2.4.9/drivers/char/drm/radeon_state.c:1103:radeon_cp_dispatch_texture: ERROR:RANGE:1021:1103: [LOOP] Looping on user length "height" set by 'inferred by call to copy_to_user, line 1057':1021 [distance=238]
	default:
		DRM_ERROR( "invalid texture format %d\n", tex->format );
		return -EINVAL;
	}

Start --->
	DRM_DEBUG( "   tex=%dx%d  blit=%d\n",

	... DELETED 76 lines ...

	} else {
		/* Texture image width is less than the minimum, so we
		 * need to pad out each image scanline to the minimum
		 * width.
		 */
Error --->
		for ( i = 0 ; i < tex->height ; i++ ) {
			if ( copy_from_user( buffer, data, tex_width ) ) {
				DRM_ERROR( "EFAULT on pad, %d bytes\n",
					   tex_width );
---------------------------------------------------------
[BUG]  no bounds check
/home/kash/linux/2.4.9/drivers/telephony/ixj.c:5093:ixj_ioctl: ERROR:RANGE:4686:5093: Using user length "arg" as an array indexfor "filter_hist" [state = tainted] set by 'inferred by call to copy_from_user, line 5096':4686
	unsigned int minor = MINOR(inode->i_rdev);
	unsigned int board = NUM(inode->i_rdev);
	IXJ *j = ixj[board];
	int retval = 0;

Start --->
	if (ixjdebug > 1)

	... DELETED 401 lines ...

		if (copy_from_user(&jf, (char *) arg, sizeof(jf)))
			return -EFAULT;
		retval = ixj_init_filter(j, &jf);
		break;
	case IXJCTL_GET_FILTER_HIST:
Error --->
		retval = j->filter_hist[arg];
		break;
	case IXJCTL_INIT_TONE:
		copy_from_user(&ti, (char *) arg, sizeof(ti));
---------------------------------------------------------
[BUG] the upper bounds check doesn't do anything
/home/kash/linux/2.4.9/drivers/char/vt.c:288:do_kdgkb_ioctl: ERROR:RANGE:281:288: Using user length "i" as an array indexfor "func_table" [state = need_ub] set by 'copy_from_user':281 [linkages -> 281:i=kb_func -> 281:tmp->kb_func -> 281:tmp:start] [distance=6]
	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
		return -EFAULT;
	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
	if (tmp.kb_func >= MAX_NR_FUNC)
		return -EINVAL;
Start --->
	i = tmp.kb_func;

	switch (cmd) {
	case KDGKBSENT:
		sz = sizeof(tmp.kb_string) - 1; /* sz should have been
						  a struct member */
		q = user_kdgkb->kb_string;
Error --->
		p = func_table[i];
		if(p)
			for ( ; *p && sz; p++, sz--)
				if (put_user(*p, q++))
---------------------------------------------------------
[BUG] the upper bounds check doesn't do anything
/home/kash/linux/2.4.9/drivers/char/vt.c:300:do_kdgkb_ioctl: ERROR:RANGE:281:300: Using user length "i" as an array indexfor "func_table" [state = need_ub] set by 'copy_from_user':281 [linkages -> 281:i=kb_func -> 281:tmp->kb_func -> 281:tmp:start] [distance=15]
	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
		return -EFAULT;
	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
	if (tmp.kb_func >= MAX_NR_FUNC)
		return -EINVAL;
Start --->
	i = tmp.kb_func;

	... DELETED 13 lines ...

		return ((p && *p) ? -EOVERFLOW : 0);
	case KDSKBSENT:
		if (!perm)
			return -EPERM;

Error --->
		q = func_table[i];
		first_free = funcbufptr + (funcbufsize - funcbufleft);
		for (j = i+1; j < MAX_NR_FUNC && !func_table[j]; j++)
			;
---------------------------------------------------------
[BUG] looks valid
/home/kash/linux/2.4.9/drivers/net/wan/sbni.c:1334:sbni_ioctl: ERROR:RANGE:1326:1334: Using user length "cur_rxl_index" as an array indexfor "rxl_tab" [state = need_ub] set by 'inferred by call to copy_from_user, line 1350':1329 [linkages -> 1329:cur_rxl_index=rxl -> 1329:flags->rxl -> 1326:(null)->(null) -> 1326:(null):start] [distance=15]
	case  SIOCDEVSHWSTATE :
		if( current->euid != 0 )	/* root only */
			return  -EPERM;

		spin_lock( &nl->lock );
Start --->
		flags = *(struct sbni_flags*) &ifr->ifr_data;
		if( flags.fixed_rxl )
			nl->delta_rxl = 0,
			nl->cur_rxl_index = flags.rxl;
		else
			nl->delta_rxl = DEF_RXL_DELTA,
			nl->cur_rxl_index = DEF_RXL;

Error --->
		nl->csr1.rxl = rxl_tab[ nl->cur_rxl_index ];
		nl->csr1.rate = flags.rate;
		outb( *(u8 *)&nl->csr1 | PR_RES, dev->base_addr + CSR1 );
		spin_unlock( &nl->lock );
---------------------------------------------------------
[BUG] not sure
/home/kash/linux/2.4.9/drivers/sound/wavfront.c:1308:wavefront_send_sample: ERROR:RANGE:1293:1308: Using user length "sample_short" as argument to "outw" [type=GLOBAL] [state = need_ub] set by '__get_user':1293 [linkages -> 1293:sample_short=(null) -> 1293:sample_short op (null) -> 1293:sample_short:start] [distance=20]
						/* 16 bit sample
						 resolution, sign
						 extend the MSB.
						*/

Start --->
						sample_short += 0x7fff;

	... DELETED 9 lines ...

				   whatever the final value was.
				*/
			}

			if (i < blocksize - 1) {
Error --->
				outw (sample_short, dev.block_port);
			} else {
				outw (sample_short, dev.last_block_port);
			}
---------------------------------------------------------
[BUG] upper bounds doesn't do anything since kb_func is unsigned char
/home/kash/linux/2.4.9/drivers/char/vt.c:302:do_kdgkb_ioctl: ERROR:RANGE:281:302: [LOOP] Looping on user length "j" set by 'copy_from_user':302 [linkages -> 302:j=(null) -> 302:i op (null) -> 281:tmp->kb_func -> 281:tmp:start] [distance=27]
	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
		return -EFAULT;
	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
	if (tmp.kb_func >= MAX_NR_FUNC)
		return -EINVAL;
Start --->
	i = tmp.kb_func;

	... DELETED 15 lines ...

		if (!perm)
			return -EPERM;

		q = func_table[i];
		first_free = funcbufptr + (funcbufsize - funcbufleft);
Error --->
		for (j = i+1; j < MAX_NR_FUNC && !func_table[j]; j++)
			;
		if (j < MAX_NR_FUNC)
			fj = func_table[j];
---------------------------------------------------------
[BUG] the upper bounds check doesn't do anything
/home/kash/linux/2.4.9/drivers/char/vt.c:302:do_kdgkb_ioctl: ERROR:RANGE:281:302: Using user length "j" as an array indexfor "func_table" [state = need_lb] set by 'copy_from_user':302 [linkages -> 302:j=(null) -> 302:i op (null) -> 281:tmp->kb_func -> 281:tmp:start] [distance=27]
	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
		return -EFAULT;
	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
	if (tmp.kb_func >= MAX_NR_FUNC)
		return -EINVAL;
Start --->
	i = tmp.kb_func;

	... DELETED 15 lines ...

		if (!perm)
			return -EPERM;

		q = func_table[i];
		first_free = funcbufptr + (funcbufsize - funcbufleft);
Error --->
		for (j = i+1; j < MAX_NR_FUNC && !func_table[j]; j++)
			;
		if (j < MAX_NR_FUNC)
			fj = func_table[j];
---------------------------------------------------------
[BUG] two bugs here.  not only can you loop on length, but if length is negative, it can do bad things with copy_from_user
/home/kash/linux/2.4.9/drivers/isdn/act2000/act2000_isa.c:445:act2000_isa_download: ERROR:RANGE:437:445: [LOOP] Looping on user length "length" set by 'copy_from_user':437 [linkages -> 437:length=length -> 437:cblock->length -> 437:cblock:start] [distance=37]
                return -ENXIO;
        act2000_isa_delay(HZ / 2);
        if ((ret = verify_area(VERIFY_READ, (void *) cb, sizeof(cblock))))
                return ret;
        copy_from_user(&cblock, (char *) cb, sizeof(cblock));
Start --->
        length = cblock.length;
        p = cblock.buffer;
        if ((ret = verify_area(VERIFY_READ, (void *) p, length)))
                return ret;
        buf = (u_char *) kmalloc(1024, GFP_KERNEL);
        if (!buf)
                return -ENOMEM;
        timeout = 0;
Error --->
        while (length) {
                l = (length > 1024) ? 1024 : length;
                c = 0;
                b = buf;
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.9/drivers/isdn/hisax/isar.c:274:isar_load_firmware: ERROR:RANGE:258:274: [LOOP] Looping on user length "left" set by 'copy_from_user':260 [linkages -> 260:left=len -> 258:blk_head:start] [distance=67]
		blk_head.d_key = sadr;
#endif /* __BIG_ENDIAN */
		cnt += BLK_HEAD_SIZE;
		p += BLK_HEAD_SIZE;
		printk(KERN_DEBUG"isar firmware block (%#x,%5d,%#x)\n",
Start --->
			blk_head.sadr, blk_head.len, blk_head.d_key & 0xff);

	... DELETED 10 lines ...

		if ((ireg->iis != ISAR_IIS_DKEY) || ireg->cmsb || len) {
			printk(KERN_ERR"isar wrong dkey response (%x,%x,%x)\n",
				ireg->iis, ireg->cmsb, len);
			ret = 1;goto reterror;
		}
Error --->
		while (left>0) {
			noc = MIN(126, left);
			nom = 2*noc;
			mp  = msg;





