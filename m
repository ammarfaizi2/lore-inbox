Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHGJTP>; Wed, 7 Aug 2002 05:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSHGJTP>; Wed, 7 Aug 2002 05:19:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:11014 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317117AbSHGJTO>; Wed, 7 Aug 2002 05:19:14 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15696.59115.395706.489896@laputa.namesys.com>
Date: Wed, 7 Aug 2002 13:22:51 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: kernel thread exit race
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: CERT root drdoom satan passwd security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

what is the politically correct way to exit from a kernel thread daemon
without module unload races?

Currently most kernel threads exit with something like

	wake_up(&daemon_done_wait_queue);
	return 0;

(or complete() in stead of wake_up()). Problem is that thread waiting
for daemon shutdown can start running on another CPU while daemon is
still executing and unload module, in particular unmapping page with
daemon code.

Reiserfs used to do something like

    /*
     * BKL will be released in do_exit()
     */
    lock_kernel();
	wake_up(&daemon_done_wait_queue);
	return 0;

and wait for daemon completion under BKL so that when waiter resumes,
daemon is definitely not executing module code. This looks like a hack,
though. Is there a better solution?

Nikita.
