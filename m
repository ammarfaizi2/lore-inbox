Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCLFxU>; Mon, 12 Mar 2001 00:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRCLFxK>; Mon, 12 Mar 2001 00:53:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8968 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129506AbRCLFxB>;
	Mon, 12 Mar 2001 00:53:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
cc: mingo@elte.hu, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog 
In-Reply-To: Your message of "Sun, 11 Mar 2001 20:43:16 -0800."
             <3AAC53E4.A8BECB23@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 16:52:07 +1100
Message-ID: <20142.984376327@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2001 20:43:16 -0800, 
george anzinger <george@mvista.com> wrote:
>Consider this.  Why not use the NMI to sync the cpus.  Kdb would have a
>function that is called each NMI.

kdb uses NMI IPI to get the other cpu's attention.  One cpu is in
control and may or may not be accepting NMI, it depends on the event
that entered kdb.  The other cpus end up in kdb code, spinning waiting
for a cpu switch.  Initially they are not receiving NMI because they
were invoked via NMI which is masked until they exit.  However if the
user does a cpu switch then single steps the interrupted code, the cpu
has to return from the NMI handler to the interrupted code at which
time this cpu starts receiving NMI again.

The kdb context can change from ignoring NMI to accepting NMI.  It is
easier to bring all the cpus into kdb and let the kdb code decide if it
ignores any NMI that is being received.

