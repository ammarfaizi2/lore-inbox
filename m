Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278176AbRJZKOL>; Fri, 26 Oct 2001 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278274AbRJZKOB>; Fri, 26 Oct 2001 06:14:01 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:53005 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S278176AbRJZKN4>; Fri, 26 Oct 2001 06:13:56 -0400
Date: Fri, 26 Oct 2001 14:14:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: cycle detection sanity checks
Message-ID: <20011026141410.A18880@jurassic.park.msu.ru>
In-Reply-To: <20011026014133.A1422@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011026014133.A1422@redhat.com>; from rth@redhat.com on Fri, Oct 26, 2001 at 01:41:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 01:41:33AM -0700, Richard Henderson wrote:
> The following adds some knowledge about what sort of hardware
> actually exists, so that we can determine that the computed
> value is completely out of line.

Ouch, we've forgotten one important thing. Due to frequency deviation
of the reference generator actual clock speed, say, 599.8 MHz of the
600 MHz CPU would be perfectly valid. However, validate_cc_value()
would fail in this case for no reason.
The 10 MHz is more than enough to cover this.
Patch applies on the top of Richard's one.

Ivan.

--- linux/arch/alpha/kernel/time.c.orig	Fri Oct 26 13:56:32 2001
+++ linux/arch/alpha/kernel/time.c	Fri Oct 26 13:58:54 2001
@@ -176,6 +176,8 @@ common_init_rtc(void)
 
    Return 0 if the result cannot be trusted, otherwise return the argument.  */
 
+#define FREQ_DEVIATION	10000000
+
 static unsigned long __init
 validate_cc_value(unsigned long cc)
 {
@@ -206,7 +208,8 @@ validate_cc_value(unsigned long cc)
 	if (index >= sizeof(cpu_hz)/sizeof(cpu_hz[0]))
 		return cc;
 
-	if (cc < cpu_hz[index].min || cc > cpu_hz[index].max)
+	if (cc < (cpu_hz[index].min - FREQ_DEVIATION)
+	    || cc > (cpu_hz[index].max + FREQ_DEVIATION)
 		return 0;
 
 	return cc;
