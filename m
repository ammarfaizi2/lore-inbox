Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDTRMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDTRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDTRMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:12:08 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:25685 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751179AbWDTRMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:12:06 -0400
X-ME-UUID: 20060420171205448.6D76C7000098@mwinf1303.wanadoo.fr
Date: Thu, 20 Apr 2006 19:11:02 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: strncpy (maybe others) broken on Alpha
Message-ID: <20060420171102.GA7272@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420101448.GA20087@localhost>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ some background here: this started as a kobject_add error from the
scsi subsystem, now it appears the strncpy routine on Alpha is broken
see http://lkml.org/lkml/fancy/2006/4/19/305 or
msgid 20060419213129.GA9148@localhost ]

On Thu, Apr 20, 2006 at 12:14:48PM +0200, Mathieu Chouquet-Stringer wrote:
> So I guess the strncpy routine on alpha is fscked up or gcc is doing
> something crazy. The function is under arch/alpha/lib/strncpy.S, time to
> learn assembly.

Replying to myself here, i've created the following test program and
redefined strncpy to mystrncpy (I used strncpy.S and stxncpy.S from
arch/alpha/lib):

=============================================================================
#include <stdio.h>
#include <string.h>
#define FOO 50

extern char *mystrncpy(char *dest, const char *src, size_t count);

int main(int argc, char **argv)
{

	char src[FOO] = "";
	char dest[FOO];
	char letter[] = "a";
	int i;

	for (i = 0; i < FOO - 1; i++) {
		size_t beflen, aftlen;

		letter[0] = 'a' + i;
		strncat(src, letter, FOO);
		beflen = strlen(src);

		mystrncpy(dest, src, FOO);
		aftlen = strlen(dest);
		if (beflen != aftlen)
			printf("fails for strlen = %ld (copied %ld)\n",
				beflen, aftlen);
	}


	return 0;
}
=============================================================================

And here's the output using gcc version 3.4.4 (Gentoo 3.4.4-r1,
ssp-3.4.4-1.0, pie-8.7.8), note i didn't use flag except -Wall:

fails for strlen = 3 (copied 2)
fails for strlen = 4 (copied 2)
fails for strlen = 5 (copied 2)
fails for strlen = 6 (copied 2)
fails for strlen = 7 (copied 2)
fails for strlen = 11 (copied 10)
fails for strlen = 12 (copied 10)
fails for strlen = 13 (copied 10)
fails for strlen = 14 (copied 10)
fails for strlen = 15 (copied 10)
fails for strlen = 19 (copied 18)
fails for strlen = 20 (copied 18)
fails for strlen = 21 (copied 18)
fails for strlen = 22 (copied 18)
fails for strlen = 23 (copied 18)
fails for strlen = 27 (copied 26)
fails for strlen = 28 (copied 26)
fails for strlen = 29 (copied 26)
fails for strlen = 30 (copied 26)
fails for strlen = 31 (copied 26)
fails for strlen = 35 (copied 34)
fails for strlen = 36 (copied 34)
fails for strlen = 37 (copied 34)
fails for strlen = 38 (copied 34)
fails for strlen = 39 (copied 34)
fails for strlen = 43 (copied 42)
fails for strlen = 44 (copied 42)
fails for strlen = 45 (copied 42)
fails for strlen = 46 (copied 42)
fails for strlen = 47 (copied 42)


So much for this function...  I'll look at the assembly to see if I can
understand what's going on: it always copy a multiple of 8 + 2 bytes (as
in 8x + 2).
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

