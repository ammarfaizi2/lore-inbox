Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbUKRRiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbUKRRiC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUKRR3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:29:16 -0500
Received: from mail.aknet.ru ([217.67.122.194]:21002 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262796AbUKRR0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:26:36 -0500
Message-ID: <419CDB6F.2090406@aknet.ru>
Date: Thu, 18 Nov 2004 20:27:11 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl> <4198EFE5.5010003@aknet.ru> <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl> <419A38EE.8000202@aknet.ru> <Pine.LNX.4.58L.0411162226500.8068@blysk.ds.pg.gda.pl> <419CB75C.3080605@aknet.ru> <Pine.LNX.4.58L.0411181557430.30376@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411181557430.30376@blysk.ds.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------020206060608010909020209"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206060608010909020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Maciej W. Rozycki wrote:
> something CPU-intensive, like:
> and observe the NMI counter ticking every second.
Ah, thanks for explanations!
Indeed it works as you say.
Very usefull info, perhaps worth
being added to documentation?
So if you ACK the attached patch,
I ask Andrew to please apply it.

Andrew, the attached patch adds
the information about the NMI
watchdog frequency caveats to the
Documentation/nmi_watchdog.txt
Unless there are any objections,
please apply.


--------------020206060608010909020209
Content-Type: text/x-patch;
 name="nmi_watchdog.txt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi_watchdog.txt.diff"

--- linux/Documentation/nmi_watchdog.txt.old	2004-10-21 21:21:56.000000000 +0400
+++ linux/Documentation/nmi_watchdog.txt	2004-11-18 20:16:37.972370552 +0300
@@ -54,6 +54,20 @@
 cannot even accept NMI interrupts, or the crash has made the kernel
 unable to print messages.
 
+Be aware that when using local APIC, the frequency of NMI interrupts
+it generates, depends on the system load. The local APIC NMI watchdog,
+lacking a better source, uses the "cycles unhalted" event. As you may
+guess it doesn't tick when the CPU is in the halted state (which happens
+when the system is idle), but if your system locks up on anything but the
+"hlt" processor instruction, the watchdog will trigger very soon as the
+"cycles unhalted" event will happen every clock tick. If it locks up on
+"hlt", then you are out of luck -- the event will not happen at all and the
+watchdog won't trigger. This is a shortcoming of the local APIC watchdog
+-- unfortunately there is no "clock ticks" event that would work all the
+time. The I/O APIC watchdog is driven externally and has no such shortcoming.  
+But its NMI frequency is much higher, resulting in a more significant hit
+to the overall system performance.
+
 NOTE: starting with 2.4.2-ac18 the NMI-oopser is disabled by default,
 you have to enable it with a boot time parameter.  Prior to 2.4.2-ac18
 the NMI-oopser is enabled unconditionally on x86 SMP boxes.

--------------020206060608010909020209--
