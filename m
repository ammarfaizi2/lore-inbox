Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJ2MtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTJ2MtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 07:49:25 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:26889 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S262055AbTJ2MtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 07:49:24 -0500
Date: Wed, 29 Oct 2003 14:48:45 +0200
From: Alexander Atanasov <alex@ssi.bg>
To: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: CMD640 IDE chipset
Message-Id: <20031029144845.14d57ba6.alex@ssi.bg>
In-Reply-To: <20031029121218.56602.qmail@web20606.mail.yahoo.com>
References: <200310271535.35762.bzolnier@elka.pw.edu.pl>
	<20031029121218.56602.qmail@web20606.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Wed, 29 Oct 2003 04:12:18 -0800 (PST)
Stefan Talpalaru <stefantalpalaru@yahoo.com> wrote:

> and also some useless code (the wrapers: __put_cmd640_reg() and 
> __get_cmd640_reg() - which I removed and placed the locks where
> needed; the pci_conf1() and pci_conf2() functions).

	These wrappers were added to correct the locking in
driver. There are places that you must access serveral registers
holding the lock and that's why the wrappers came, so they
are not useless. The locking in your patch is wrong -
the problem is that you call get_cmd640_reg or put_cmd640_reg, which
try to take ide_lock, while already holding it and it's a deadlock 
- thats what the wrappers solved. So, please , drop that change.


       setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
-       __put_cmd640_reg(arttim_regs[index], setup_count);
-       __put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery
_count));
+       setup_count |= get_cmd640_reg(arttim_regs[index]) & 0x3f;
+       put_cmd640_reg(arttim_regs[index], setup_count);
+       put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_c
ount));
        spin_unlock_irqrestore(&ide_lock, flags);
 }

	here

-       __put_cmd640_reg(reg, b);
+       put_cmd640_reg(reg, b);
        spin_unlock_irqrestore(&ide_lock, flags);

	and here for example.

--
have fun,
alex
