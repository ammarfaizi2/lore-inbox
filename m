Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbREaMFR>; Thu, 31 May 2001 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbREaMFG>; Thu, 31 May 2001 08:05:06 -0400
Received: from mail.inup.com ([194.250.46.226]:28677 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263079AbREaME7>;
	Thu, 31 May 2001 08:04:59 -0400
Date: Thu, 31 May 2001 14:03:45 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Fiber Channel Driver
Message-ID: <20010531140345.F21455@pc8.lineo.fr>
In-Reply-To: <20010531133550.E21455@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010531133550.E21455@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Thu, May 31, 2001 at 13:35:50 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying the Fiber Channel driver for the isp2x00 chip.
This driver supports both SCSI and IP.
I've some questions about the implementation. 

I've made some unsuccessfull internet search.
The better URL I've found is the following one :
	http://www.iol.unh.edu/consortiums/fc/linux/qlogic.html
This URL points Chris Loveland (cwl@iol.unh.edu) as the maintener.
But the mail address is no more valid.
    (reason: 550 <cwl@iol.unh.edu>... User unknown)
Has someone a more acurate e-mail address?

The driver (qlogicfc.c qlogicfc.h qlogicfc_asm.c) provide a firmware
(v1.17.30). I know this is a recuring lkml subject but it comes in a
microcode form and so it's hard to know what it does. I would greatly
appreciate if someone can indicate me some documents.

Moreover this firmware (copyrigth-ed by QLogic) differs from the one
currently distributed by Qlogic (v1.19.16). 
Qlogic provides a driver which as-is doen't support IP. In the source we
can see that everything is there to support it. In the makefile we see that
we can build all with IP support but two files are missing. They certainly
do what they want with their drivers (why hide a driver?) but what estonish
me is that they have two firmware versions : one special for IP support
(and
this is one of the missing files). 

So Why I'm so interrested in the firmware ?
Because I believe the QLogic driver is better implemented. I can see that
this driver is an evolution from the one actually in the kernel. 

The driver in the kernel have some strange things like :
-> X seconds busy loop (when using the driver, the system sometimes lock
during few seconds).
-> Re-entrance in functions that IMHO don't support that:
	qlogicfc.c:isp2x00_queuecommand()
-> Some interesting comments like the one who introduces
isp2x00_mbox_command().

/*
 * currently, this is only called during initialization or abort/reset,
 * at which times interrupts are disabled, so polling is OK, I guess...
 */
static int isp2x00_mbox_command(struct Scsi_Host *host, u_short param[])
{
 ...
	while (--loop_count && inw(host->io_port + HOST_HCCR) & 0x0080)
		barrier();
 ...
		isp2x00_intr_handler(host->irq, host, NULL);
 ...
}

So I started to modify the code to use a thread to queue commands and to
avoid locking the kernel with busy loop.
I'm on the way but I've since found that this is what does the QLogic
driver (except that they hide the IP support). I would like to take part of
the code (under GPL) but I'm not sure that the firmware (older version)
would allow that.

Any Remarqs, Suggestions Links would be good.

Thank you,
Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

