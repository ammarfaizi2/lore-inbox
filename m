Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280872AbRKBXPf>; Fri, 2 Nov 2001 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280875AbRKBXP0>; Fri, 2 Nov 2001 18:15:26 -0500
Received: from saga18.Stanford.EDU ([171.64.15.148]:46574 "EHLO
	saga18.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S280872AbRKBXPQ>; Fri, 2 Nov 2001 18:15:16 -0500
Date: Fri, 2 Nov 2001 15:15:10 -0800 (PST)
From: Ken Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <engler@cs.stanford.edu>
Subject: [CHECKER] 8 probable security errors
Message-ID: <Pine.GSO.4.33.0111021443080.6907-100000@saga18.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been through the list of security errors that I reported in the past
to see which ones were fixed and which ones were ignored.  I've come up
with this list of 8 errors that look to me like they should really be
fixed but were not.  The first four errors look the most serious.  If
these are false positives, please let me know.

A description of the checker and the errors are below.

Ken Ashcraft

ps- I'd like to thank everyone who has taken the time to fix the errors
I've reported in the past and for explaining when I've been wrong.  I
really appreciate it.
--------------------------------------------------
The checker makes sure that bounds checks are present before a user length
is:

	1. passed as a length argument to copy_*user (or passed to a
		function that does)
	2. is used as an array index.
	3. passed as the size argument to *malloc (this is a minor bug
		as *malloc will fail if the size is too large, but bad
		things can happen if the argument overflows because of
		multiplication (i.e. the argument to malloc is
		(userlen * sizeof(struct big_struct)) and only a small
		amount of memory is alloc'd instead))
		These errors are marked with "LOCAL MINOR" so you can
ignore
		them if you don't want them.
	4. used as part of the conditional expression of a loop (most of
		the time these errors result in the user being able to
		make the loop go for a long time.)
	5. passed to any function that does one of the above things.

The checker not only looks at user lengths that it knows come directly
from the user (via copy_from_user, get_user, etc.), but it can also infer
that a length comes from the user:  Ioctl's often have an argument passed
to them that is used in different ways-- in one case of a switch
statement, it could be the destination of copy_to_user and in another
case, it could be the length argument of copy_from_user.  If that
parameter is a destination for copy_to_user or the source for
copy_from_user, we infer that it comes from the user and we look at other
uses of it in the same function.

We also look at data that comes off the network (meaning that it comes out
of an skb).  While it is difficult to determine if the data in incoming or
outgoing, I'm pretty sure that the errors here are valid.

We also check when a user length is passed to a function pointer.  I made
a list of all functions that are assigned to that field and if one of
those functions does the bad things listed above, it is marked as an
error.  It is possible that the function pointer could not actually be
that function at that point in the code.  This type of error is notated
with "Possibly using user length..."

---------------------------------------------------------
[BUG] doesn't check cmd.length.
/home/kash/linux/2.4.12-ac3/drivers/net/wan/sdla_fr.c:1158:wpf_exec: ERROR:RANGE:1157:1158: Using user length "length" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1157 [distance=12]

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
[BUG]  dataxferlen is never checked.
/home/kash/linux/2.4.12-ac3/drivers/scsi/megaraid.c:4884:megadev_ioctl: ERROR:RANGE:4884:4884: Using user length "dataxferlen" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':4884 [distance=1]
			ioc.data = kvaddr;

			if (inlen) {
				if (ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU) {
					/* copyin the user data */

Error --->
					copy_from_user (kvaddr, uaddr, ioc.pthru.dataxferlen);
---------------------------------------------------------
[BUG] tex gets copied in on line 1365.  there are a number of paths to get to this error (gem)
/home/kash/linux/2.4.12-ac3/drivers/char/drm/radeon_state.c:1107:radeon_cp_dispatch_texture: ERROR:RANGE:1000:1107: Using user length "tex_width" as argument to "copy_from_user" [type=LOCAL] [state = need_lb] set by 'inferred by call to copy_to_user, line 1058':1000 [linkages -> 1000:tex_width=(null) -> 1000:width op (null) -> 1000:tex->width -> 1000:tex:start] [distance=82]

968  static int radeon_cp_dispatch_texture( drm_device_t *dev,       Start
996          switch ( tex->format ) {                                Switch
997          case RADEON_TXFORMAT_ARGB8888:                          Case
998          case RADEON_TXFORMAT_RGBA8888:                          Case
1000                 tex_width = tex->width * 4;                     start => need_lb
1002                 break;                                          Break
1093         if ( tex_width >= 32 ) {                                If: false
1106                 for ( i = 0 ; i < tex->height ; i++ ) {         For: true
1107                         if ( copy_from_user( buffer, data, t    Error: tex_width
---------------------------------------------------------
[BUG]  tex gets copied in on line 1365.
/home/kash/linux/2.4.12-ac3/drivers/char/drm/radeon_state.c:1106:radeon_cp_dispatch_texture: ERROR:RANGE:1022:1106: [LOOP] Looping on user length "height" set by 'inferred by call to copy_to_user, line 1058':1022 [distance=78]

968  static int radeon_cp_dispatch_texture( drm_device_t *dev,       Start
1022         DRM_DEBUG( "   tex=%dx%d  blit=%d\n",                   Do, start => tainted
1093         if ( tex_width >= 32 ) {                                If: false
1106                 for ( i = 0 ; i < tex->height ; i++ ) {
For: false, Error: tex->height
---------------------------------------------------------
[BUG]3 looks very likely
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
[BUG]3  i think so.  there is a check (dump.offset + dump.length >
card->hw.memory)) that can be fooled with well chosen offset values.

/home/kash/linux/2.4.5/drivers/net/wan/sdlamain.c:1034:ioctl_dump: ERROR:RANGE:972:1034: Using user length "length" as argument to "copy_to_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':982 [linkages -> 982:dump->length -> 972:dump:start] [distance=46]

	unsigned long oldvec;	/* DPM window vector */
	unsigned long smp_flags;
	int err = 0;

      #if defined(LINUX_2_1) || defined(LINUX_2_4)
Start --->
	if(copy_from_user((void*)&dump, (void*)u_dump, sizeof(sdla_dump_t)))

	... DELETED 56 lines ...


	}else {

	     #if defined(LINUX_2_1) || defined(LINUX_2_4)
               if(copy_to_user((void *)dump.ptr,
Error --->
			       (u8 *)card->hw.dpmbase + dump.offset, dump.length)){
			return -EFAULT;
		}
             #else

---------------------------------------------------------
[BUG]3 array index
/home/kash/linux/2.4.9-ac7/drivers/scsi/dpt_i2o.c:1962:adpt_ioctl: ERROR:RANGE:1962:1962: Using user length "id" as argument to "adpt_find_device" [type=GLOBAL] [state = need_ub] set by 'copy_from_user':1962 [distance=1]

		if (copy_from_user((void*)&busy, (void*)arg, sizeof(TARGET_BUSY_T))) {
			return -EFAULT;
		}


Error --->
		d = adpt_find_device(pHba, busy.channel, busy.id, busy.lun);
---------------------------------------------------------
[BUG]3 looks valid
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

