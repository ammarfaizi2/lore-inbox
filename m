Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269267AbTCBS0z>; Sun, 2 Mar 2003 13:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269268AbTCBS0z>; Sun, 2 Mar 2003 13:26:55 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43531 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269267AbTCBS0y>; Sun, 2 Mar 2003 13:26:54 -0500
Date: Sun, 2 Mar 2003 19:37:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
In-Reply-To: <200303021733.JAA15313@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0303021928090.32518-100000@serv>
References: <200303021733.JAA15313@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Mar 2003, Adam J. Richter wrote:

> 	Is there enough traffic on the module reference counts to make
> this trade-off worthwhile?

I don't know, you have to ask that Rusty.
BTW the same trick is also possible with the old module count:

int try_inc_mod_count(struct module *mod)
{
	int res;

	if (mod) {
		__MOD_INC_USE_COUNT(mod);
		smp_mb__after_atomic_inc()
		if (unlikely(mod->flags & MOD_DELETED))
			goto check;
	}
	return 1;
check:
	res = 1;
	spin_lock(&unload_lock);
	if (mod->flags & MOD_DELETED) {
		__MOD_DEC_USE_COUNT(mod);
		res = 0;
	}
	spin_unlock(&unload_lock);
	return res;
}

(and a similiar change to sys_delete_module.)

bye, Roman

