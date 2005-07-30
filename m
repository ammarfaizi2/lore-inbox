Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbVG3UER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVG3UER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVG3UEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:04:16 -0400
Received: from opersys.com ([64.40.108.71]:42767 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263151AbVG3UEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:04:09 -0400
Message-ID: <42EBDBA5.5090008@opersys.com>
Date: Sat, 30 Jul 2005 15:57:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Average instruction length in x86-built kernel?
References: <42EAA05F.4000704@opersys.com> <200507301549.32528.ioe-lkml@rameria.de>
In-Reply-To: <200507301549.32528.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ingo,

Ingo Oeser wrote:
> Just study the output od objdump -d and average the differences
> of the first hex number in a line printed, which are followed by a ":"

Here's a script that does what I was looking for:
#!/bin/bash

# Dissassemble
objdump -d $1 -j .text > $2-dissassembled-kernel

# Remove non-instruction lines:
sed /^[^c].*/d $2-dissassembled-kernel > $2-stage-1

# Remove empty lines:
sed /^'\t'*$/d $2-stage-1 > $2-stage-2

# Remove function names:
sed /^c[0-9,a-f]*' '\<.*\>:$/d $2-stage-2 > $2-stage-3

# Remove addresses:
sed s/^c[0-9,a-f]*:'\t'// $2-stage-3 > $2-stage-4

# Remove instruction text:
sed s/'\t'.*// $2-stage-4 > $2-stage-5

# Remove trailing whitespace:
sed s/'\s'*$// $2-stage-5 > $2-stage-6

# Separate instructions depending on size:
egrep "([0-9a-f]{2}[' ']*){5}" $2-stage-6 > $2-more-or-eq-5
egrep "^([0-9a-f]{2}[' ']*){0,4}$" $2-stage-6 > $2-less-or-eq-4

# Find out how much of each we've got:
wc -l $2-stage-6
wc -l $2-more-or-eq-5
wc -l $2-less-or-eq-4

The last part can easily be changed to iterate through and separate
those that are 1 byte, 2 bytes, etc. and automatically come up with
stats, but this was fine for what I was looking for.

I ran it on a 2.4.x and a 2.6.x kernel and about 3/4 of instructions
are 4 bytes or less.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
