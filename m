Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVDFXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVDFXsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVDFXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:48:23 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:18887 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262356AbVDFXsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:48:18 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] CON_CONSDEV bit not set correctly on last console
Date: Wed, 6 Apr 2005 23:48:17 +0000 (UTC)
Organization: Cistron
Message-ID: <d31sg1$mci$1@news.cistron.nl>
References: <20050405191003.GO21725@sgi.com> <20050406155317.54792458.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1112831297 22930 194.109.0.112 (6 Apr 2005 23:48:17 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050406155317.54792458.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
>Greg Edwards <edwardsg@sgi.com> wrote:
>>
>> According to include/linux/console.h, CON_CONSDEV flag should be set on
>> the last console specified on the boot command line:
>> 
>>      86 #define CON_PRINTBUFFER (1)
>>      87 #define CON_CONSDEV     (2) /* Last on the command line */
>>      88 #define CON_ENABLED     (4)
>>      89 #define CON_BOOT        (8)
>> 
>> This does not currently happen if there is more than one console specified
>> on the boot commandline.  Instead, it gets set on the first console on the
>> command line.  This can cause problems for things like kdb that look for
>> the CON_CONSDEV flag to see if the console is valid.
>> 
>> Additionaly, it doesn't look like CON_CONSDEV is reassigned to the next
>> preferred console at unregister time if the console being unregistered
>> currently has that bit set.
>> 
>> Example (from sn2 ia64):
>> 
>> elilo vmlinuz root=<dev> console=ttyS0 console=ttySG0
>> 
>> in this case, the flags on ttySG console struct will be 0x4 (should be
>> 0x6).
>> 
>> Attached patch against bk fixes both issues for the cases I looked at.  It
>> uses selected_console (which gets incremented for each console specified
>> on the command line) as the indicator of which console to set CON_CONSDEV
>> on.  When adding the console to the list, if the previous one had
>> CON_CONSDEV set, it masks it out.  Tested on ia64 and x86.
>
>The `console=a console=b' behaviour seem basically random to me :(.  And it
>gets re-randomised on a regular basis.

Well, on the other hand the last registered console is the one
that connects to /dev/console and that has never changed afaik
(and it shouldn't, many setups rely on it).

Mike.

