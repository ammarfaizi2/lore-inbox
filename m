Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUG2ELY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUG2ELY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUG2ELY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 00:11:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:44812 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264147AbUG2ELE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 00:11:04 -0400
To: Paul Jackson <pj@sgi.com>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Jul 2004 13:10:16 +0900
In-Reply-To: <20040728134202.5938b275.pj@sgi.com>
Message-ID: <87llh3ihcn.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> -#define i (tmp.kb_index)
> -#define s (tmp.kb_table)
> -#define v (tmp.kb_value)
>  static inline int
>  do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm, struct kbd_struct *kbd)
>  {
>  	struct kbentry tmp;
>  	ushort *key_map, val, ov;
> +	unsigned char s, i;
> +	unsigned short v;
>  
>  	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
>  		return -EFAULT;
>  
> +	s = tmp.kb_table;
> +	i = tmp.kb_index;
> +	v = tmp.kb_value;

Yes, s/i/v macro is ugly.  But I think it shouldn't, because it limits
the range when struct kbentry was changed.  (I think this change is likely)

Perhaps only expand the macro... hmm..

> +	if (s >= ARRAY_SIZE(key_maps))
> +		return -EINVAL;
> +	if (i >= ARRAY_SIZE(key_map))
> +		return -EINVAL;

key_map is pointer, so ARRAY_SIZE() can't use.  Anyhow these will be
warned by gcc.

Although overhead is insignificance, I'd hated to add overhead of this
test because test is not needed right now.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
