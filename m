Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUEaGKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUEaGKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUEaGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:10:31 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:32210 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264543AbUEaGJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:09:55 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch - please comment] Support for UTF dead keys in 2.6
Date: Mon, 31 May 2004 08:09:46 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040529143421.GA15127@ucw.cz>
In-Reply-To: <20040529143421.GA15127@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405310809.49059.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 29 May 2004 16:34, Vojtech Pavlik wrote:
> Hi!
> 
> Several languages (polish, czech, slovak, ...) use dead keys (keys that
> don't do anything per se, but put an accent on the next letter). And now
> almost everyone is switching to unicode. And Linux kernel doesn't
> support unicode for dead keys. This means trouble.
> 
> The patch (ported from original 2.4 version by Radovan Garabik)  below
> fixes the problem. Is anyone opposed to it? If not, I'll merge it into
> my tree and send to Linus.
> 
> It needs a patch to loadkeys to do something. It should be 100% binary
> and source backward compatible.
> 
> ChangeSet@1.1610, 2004-05-03 12:38:37+02:00, vojtech@suse.cz
>   input: Make accent tables able to generate unicode characters. This
>          is needed for UTF8 console with multi-keystroke characters.
> 
> 
>  drivers/acorn/char/defkeymap-l7200.c |    2 -
>  drivers/char/defkeymap.c_shipped     |    2 -
>  drivers/char/keyboard.c              |   34 ++++++++++++-----
>  drivers/char/qtronixmap.c_shipped    |    2 -
>  drivers/char/vt_ioctl.c              |   46 ++++++++++++++++++++++--
>  drivers/s390/char/defkeymap.c        |    2 -
>  drivers/s390/char/keyboard.c         |   67 ++++++++++++++++++++++++++++-------
>  drivers/s390/char/keyboard.h         |    2 -
>  drivers/tc/lk201-map.c_shipped       |    2 -
>  include/linux/kbd_diacr.h            |    2 -
>  include/linux/kd.h                   |   14 +++++++
>  11 files changed, 143 insertions(+), 32 deletions(-)
> 
> 
> diff -Nru a/drivers/acorn/char/defkeymap-l7200.c b/drivers/acorn/char/defkeymap-l7200.c
> --- a/drivers/acorn/char/defkeymap-l7200.c	Mon May  3 12:39:59 2004
> +++ b/drivers/acorn/char/defkeymap-l7200.c	Mon May  3 12:39:59 2004
> @@ -346,7 +346,7 @@
>  	0,
>  };
>  
> -struct kbdiacr accent_table[MAX_DIACR] = {
> +struct kbdiacruc accent_table[MAX_DIACR] = {
>  	{'`', 'A', '\300'},	{'`', 'a', '\340'},
>  	{'\'', 'A', '\301'},	{'\'', 'a', '\341'},
>  	{'^', 'A', '\302'},	{'^', 'a', '\342'},
> diff -Nru a/drivers/char/defkeymap.c_shipped b/drivers/char/defkeymap.c_shipped
> --- a/drivers/char/defkeymap.c_shipped	Mon May  3 12:39:59 2004
> +++ b/drivers/char/defkeymap.c_shipped	Mon May  3 12:39:59 2004
> @@ -222,7 +222,7 @@
>  	0,
>  };
>  
> -struct kbdiacr accent_table[MAX_DIACR] = {
> +struct kbdiacruc accent_table[MAX_DIACR] = {
>  	{'`', 'A', '\300'},	{'`', 'a', '\340'},
>  	{'\'', 'A', '\301'},	{'\'', 'a', '\341'},
>  	{'^', 'A', '\302'},	{'^', 'a', '\342'},
> diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> --- a/drivers/char/keyboard.c	Mon May  3 12:39:59 2004
> +++ b/drivers/char/keyboard.c	Mon May  3 12:39:59 2004
> @@ -331,7 +331,7 @@
>   * in utf-8 already. UTF-8 is defined for words of up to 31 bits,
>   * but we need only 16 bits here
>   */
> -void to_utf8(struct vc_data *vc, ushort c) 
> +void to_utf8(struct vc_data *vc, unsigned int c) 
>  {
>  	if (c < 0x80)
>  		/*  0******* */
> @@ -387,13 +387,12 @@
>  }
>  
>  /*
> - * We have a combining character DIACR here, followed by the character CH.
> - * If the combination occurs in the table, return the corresponding value.
> - * Otherwise, if CH is a space or equals DIACR, return DIACR.
> - * Otherwise, conclude that DIACR was not combining after all,
> - * queue it and return CH.
> + * We have a combining character DIACR here, followed by the character CH.  If
> + * the combination occurs in the table, return the corresponding UCS2 value.
> + * Otherwise, if CH is a space or equals DIACR, return DIACR.  Otherwise,
> + * conclude that DIACR was not combining after all, queue it and return CH.
>   */
> -unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
> +unsigned int handle_diacr(struct vc_data *vc, unsigned char ch)
>  {
>  	int d = diacr;
>  	int i;
> @@ -616,11 +615,26 @@
>  
>  static void k_self(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
>  {
> +	unsigned int v;
> +
> +
>  	if (up_flag)
>  		return;		/* no action, if this is a key release */
>  
> -	if (diacr)
> -		value = handle_diacr(vc, value);
> +	if (diacr) {
> +		v = handle_diacr(vc, value);
> +
> +		if (kbd->kbdmode == VC_UNICODE) {
> +			to_utf8(vc, v & 0xFFFF);
> +			return;
> +		}
> +
> +		/* 
> +		 * this makes at least latin-1 compose chars work 
> +		 * even when using unicode keymap in non-unicode mode
> +		 */
> +		value = v & 0xFF; 
> +	}
>  
>  	if (dead_key_next) {
>  		dead_key_next = 0;
> @@ -639,7 +653,7 @@
>  {
>  	if (up_flag)
>  		return;
> -	diacr = (diacr ? handle_diacr(vc, value) : value);
> +	diacr = (diacr ? handle_diacr(vc, value) & 0xff : value);
>  }
>  
>  /*
> diff -Nru a/drivers/char/qtronixmap.c_shipped b/drivers/char/qtronixmap.c_shipped
> --- a/drivers/char/qtronixmap.c_shipped	Mon May  3 12:39:59 2004
> +++ b/drivers/char/qtronixmap.c_shipped	Mon May  3 12:39:59 2004
> @@ -225,7 +225,7 @@
>  	0,
>  };
>  
> -struct kbdiacr accent_table[MAX_DIACR] = {
> +struct kbdiacruc accent_table[MAX_DIACR] = {
>  	{'`', 'A', '?'},	{'`', 'a', '?'},
>  	{'\'', 'A', 'Á'},	{'\'', 'a', 'á'},
>  	{'^', 'A', 'Â'},	{'^', 'a', 'â'},
> diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
> --- a/drivers/char/vt_ioctl.c	Mon May  3 12:39:59 2004
> +++ b/drivers/char/vt_ioctl.c	Mon May  3 12:39:59 2004
> @@ -584,10 +584,28 @@
>  	case KDGKBDIACR:
>  	{
>  		struct kbdiacrs *a = (struct kbdiacrs *)arg;
> +		struct kbdiacr diacr;
> +		int i;
>  
>  		if (put_user(accent_table_size, &a->kb_cnt))
>  			return -EFAULT;
> -		if (copy_to_user(a->kbdiacr, accent_table, accent_table_size*sizeof(struct kbdiacr)))
> +		for (i = 0; i < accent_table_size; i++) {
> +			diacr.diacr = accent_table[i].diacr;
> +			diacr.base = accent_table[i].base;
> +			diacr.result = accent_table[i].result> 0xff ? 0 : accent_table[i].base;
> +			if (copy_to_user(a->kbdiacr + i, &diacr, sizeof(struct kbdiacr)))
> +				return -EFAULT;
> +		}
> +		return 0;
> +	}
> +
> +	case KDGKBDIACRUC:
> +	{
> +		struct kbdiacrsuc *a = (struct kbdiacrsuc *)arg;
> +
> +		if (put_user(accent_table_size, &a->kb_cnt))
> +			return -EFAULT;
> +		if (copy_to_user(a->kbdiacruc, accent_table, accent_table_size*sizeof(struct kbdiacruc)))
>  			return -EFAULT;
>  		return 0;
>  	}
> @@ -595,6 +613,30 @@
>  	case KDSKBDIACR:
>  	{
>  		struct kbdiacrs *a = (struct kbdiacrs *)arg;
> +		struct kbdiacr diacr;
> +		unsigned int ct;
> +		int i;
> +
> +		if (!perm)
> +			return -EPERM;
> +		if (get_user(ct,&a->kb_cnt))
> +			return -EFAULT;
> +		if (ct >= MAX_DIACR)
> +			return -EINVAL;
> +		accent_table_size = ct;
> +		for (i = 0; i < ct; i++) {
> +			if (copy_from_user(&diacr, a->kbdiacr, sizeof(struct kbdiacr)))
> +				return -EFAULT;
> +			accent_table[i].diacr = diacr.diacr;
> +			accent_table[i].base = diacr.base;
> +			accent_table[i].result = diacr.result;
> +		}
> +		return 0;
> +	}
> +
> +	case KDSKBDIACRUC:
> +	{
> +		struct kbdiacrsuc *a = (struct kbdiacrsuc *)arg;
>  		unsigned int ct;
>  
>  		if (!perm)
> @@ -604,7 +646,7 @@
>  		if (ct >= MAX_DIACR)
>  			return -EINVAL;
>  		accent_table_size = ct;
> -		if (copy_from_user(accent_table, a->kbdiacr, ct*sizeof(struct kbdiacr)))
> +		if (copy_from_user(accent_table, a->kbdiacruc, ct*sizeof(struct kbdiacruc)))
>  			return -EFAULT;
>  		return 0;
>  	}
> diff -Nru a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
> --- a/drivers/s390/char/defkeymap.c	Mon May  3 12:39:59 2004
> +++ b/drivers/s390/char/defkeymap.c	Mon May  3 12:39:59 2004
> @@ -148,7 +148,7 @@
>  	0,
>  };
>  
> -struct kbdiacr accent_table[MAX_DIACR] = {
> +struct kbdiacruc accent_table[MAX_DIACR] = {
>  	{'^', 'c', '\003'},	{'^', 'd', '\004'},
>  	{'^', 'z', '\032'},	{'^', '\012', '\000'},
>  };
> diff -Nru a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
> --- a/drivers/s390/char/keyboard.c	Mon May  3 12:39:59 2004
> +++ b/drivers/s390/char/keyboard.c	Mon May  3 12:39:59 2004
> @@ -87,11 +87,11 @@
>  		goto out_func;
>  	memset(kbd->fn_handler, 0, sizeof(fn_handler_fn *) * NR_FN_HANDLER);
>  	kbd->accent_table =
> -		kmalloc(sizeof(struct kbdiacr)*MAX_DIACR, GFP_KERNEL);
> +		kmalloc(sizeof(struct kbdiacruc)*MAX_DIACR, GFP_KERNEL);
>  	if (!kbd->accent_table)
>  		goto out_fn_handler;
>  	memcpy(kbd->accent_table, accent_table,
> -	       sizeof(struct kbdiacr)*MAX_DIACR);
> +	       sizeof(struct kbdiacruc)*MAX_DIACR);
>  	kbd->accent_table_size = accent_table_size;
>  	return kbd;
>  
> @@ -464,7 +464,6 @@
>  kbd_ioctl(struct kbd_data *kbd, struct file *file,
>  	  unsigned int cmd, unsigned long arg)
>  {
> -	struct kbdiacrs *a;
>  	int ct, perm;
>  
>  	/*
> @@ -482,28 +481,70 @@
>  	case KDSKBSENT:
>  		return do_kdgkb_ioctl(kbd, (struct kbsentry *)arg, cmd, perm);
>  	case KDGKBDIACR:
> -		a = (struct kbdiacrs *) arg;
> +	{
> +		struct kbdiacrs *a = (struct kbdiacrs *)arg;
> +		struct kbdiacr diacr;
> +		int i;
>  
> -		if (put_user(kbd->accent_table_size, &a->kb_cnt))
> +		if (put_user(accent_table_size, &a->kb_cnt))
>  			return -EFAULT;
> -		ct = kbd->accent_table_size;
> -		if (copy_to_user(a->kbdiacr, kbd->accent_table,
> -				 ct * sizeof(struct kbdiacr)))
> +		for (i = 0; i < accent_table_size; i++) {
> +			diacr.diacr = accent_table[i].diacr;
> +			diacr.base = accent_table[i].base;
> +			diacr.result = accent_table[i].base > 0xff ? 0 : accent_table[i].base;
> +			if (copy_to_user(a->kbdiacr + i, &diacr, sizeof(struct kbdiacr)))
> +				return -EFAULT;
> +		}
> +		return 0;
> +	}
> +	case KDGKBDIACRUC:
> +	{
> +		struct kbdiacrsuc *a = (struct kbdiacrsuc *)arg;
> +
> +		if (put_user(accent_table_size, &a->kb_cnt))
> +			return -EFAULT;
> +		if (copy_to_user(a->kbdiacruc, accent_table, accent_table_size*sizeof(struct kbdiacruc)))
>  			return -EFAULT;
>  		return 0;
> +	}
>  	case KDSKBDIACR:
> -		a = (struct kbdiacrs *) arg;
> +	{
> +		struct kbdiacrs *a = (struct kbdiacrs *)arg;
> +		struct kbdiacr diacr;
> +		int i;
> +
>  		if (!perm)
>  			return -EPERM;
> -		if (get_user(ct, &a->kb_cnt))
> +		if (get_user(ct,&a->kb_cnt))
>  			return -EFAULT;
>  		if (ct >= MAX_DIACR)
>  			return -EINVAL;
> -		kbd->accent_table_size = ct;
> -		if (copy_from_user(kbd->accent_table, a->kbdiacr,
> -				   ct * sizeof(struct kbdiacr)))
> +		accent_table_size = ct;
> +		for (i = 0; i < ct; i++) {
> +			if (copy_from_user(&diacr, a->kbdiacr, sizeof(struct kbdiacr)))
> +				return -EFAULT;
> +			accent_table[i].diacr = diacr.diacr;
> +			accent_table[i].base = diacr.base;
> +			accent_table[i].result = diacr.result;
> +		}
> +		return 0;
> +	}
> +	case KDSKBDIACRUC:
> +	{
> +		struct kbdiacrsuc *a = (struct kbdiacrsuc *)arg;
> +		unsigned int ct;
> +
> +		if (!perm)
> +			return -EPERM;
> +		if (get_user(ct,&a->kb_cnt))
> +			return -EFAULT;
> +		if (ct >= MAX_DIACR)
> +			return -EINVAL;
> +		accent_table_size = ct;
> +		if (copy_from_user(accent_table, a->kbdiacruc, ct*sizeof(struct kbdiacruc)))
>  			return -EFAULT;
>  		return 0;
> +	}
>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> diff -Nru a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
> --- a/drivers/s390/char/keyboard.h	Mon May  3 12:39:59 2004
> +++ b/drivers/s390/char/keyboard.h	Mon May  3 12:39:59 2004
> @@ -25,7 +25,7 @@
>  	unsigned short **key_maps;
>  	char **func_table;
>  	fn_handler_fn **fn_handler;
> -	struct kbdiacr *accent_table;
> +	struct kbdiacruc *accent_table;
>  	unsigned int accent_table_size;
>  	unsigned char diacr;
>  	unsigned short sysrq;
> diff -Nru a/drivers/tc/lk201-map.c_shipped b/drivers/tc/lk201-map.c_shipped
> --- a/drivers/tc/lk201-map.c_shipped	Mon May  3 12:39:59 2004
> +++ b/drivers/tc/lk201-map.c_shipped	Mon May  3 12:39:59 2004
> @@ -225,7 +225,7 @@
>  	0,
>  };
>  
> -struct kbdiacr accent_table[MAX_DIACR] = {
> +struct kbdiacruc accent_table[MAX_DIACR] = {
>  	{'`', 'A', '?'},	{'`', 'a', '?'},
>  	{'\'', 'A', 'Á'},	{'\'', 'a', 'á'},
>  	{'^', 'A', 'Â'},	{'^', 'a', 'â'},
> diff -Nru a/include/linux/kbd_diacr.h b/include/linux/kbd_diacr.h
> --- a/include/linux/kbd_diacr.h	Mon May  3 12:39:59 2004
> +++ b/include/linux/kbd_diacr.h	Mon May  3 12:39:59 2004
> @@ -2,7 +2,7 @@
>  #define _DIACR_H
>  #include <linux/kd.h>
>  
> -extern struct kbdiacr accent_table[];
> +extern struct kbdiacruc accent_table[];
>  extern unsigned int accent_table_size;
>  
>  #endif /* _DIACR_H */
> diff -Nru a/include/linux/kd.h b/include/linux/kd.h
> --- a/include/linux/kd.h	Mon May  3 12:39:59 2004
> +++ b/include/linux/kd.h	Mon May  3 12:39:59 2004
> @@ -121,12 +121,26 @@
>          unsigned int kb_cnt;    /* number of entries in following array */
>  	struct kbdiacr kbdiacr[256];    /* MAX_DIACR from keyboard.h */
>  };
> +
>  #define KDGKBDIACR      0x4B4A  /* read kernel accent table */
>  #define KDSKBDIACR      0x4B4B  /* write kernel accent table */
>  
> +struct kbdiacruc {
> +        unsigned char diacr, base;
> +	unsigned int result;	/* UCS */
> +};
> +struct kbdiacrsuc {
> +        unsigned int kb_cnt;    /* number of entries in following array */
> +	struct kbdiacruc kbdiacruc[256];    /* MAX_DIACR from keyboard.h */
> +};
> +
> +#define KDGKBDIACRUC    0x4BFA  /* read kernel accent table - UCS */
> +#define KDSKBDIACRUC    0x4BFB  /* write kernel accent table  - UCS */
> +
>  struct kbkeycode {
>  	unsigned int scancode, keycode;
>  };
> +
>  #define KDGETKEYCODE	0x4B4C	/* read kernel keycode table entry */
>  #define KDSETKEYCODE	0x4B4D	/* write kernel keycode table entry */
>  
> 



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAuswqU56oYWuOrkARArshAKCjB3NJwj9qPirGqNP5dznxtJVtqQCffxIC
YoD8bLnLs/mB0QLO+LFJwVI=
=dLeI
-----END PGP SIGNATURE-----
