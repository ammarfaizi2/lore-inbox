Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314068AbSDVGkw>; Mon, 22 Apr 2002 02:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314070AbSDVGkv>; Mon, 22 Apr 2002 02:40:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43275 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314068AbSDVGku>; Mon, 22 Apr 2002 02:40:50 -0400
Message-Id: <200204220638.g3M6cGX10365@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: /proc/stat weirdness
Date: Mon, 22 Apr 2002 09:41:26 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0204211427110.21092-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 April 2002 16:27, Mark Hahn wrote:
> > * top with continuous update
> > * output of "while true; do cat /proc/stat; done | grep -F 'cpu  '"
>
> I told you, I don't ever see any of this phenomenon.

I'd like to add that it is easily seen only on slower boxes.
It was really hard to catch on PIII 800 (1458 BogoMIPS):
top was too slow refreshing, cat script however was fast enough when 
redirected to file to show backstepping. See below.

Hey lkml folks, please run:
# while true; do cat /proc/stat; done | grep -F 'cpu  ' >/tmp/log
do you see something like this?

cpu  1170 0 3066 28631
cpu  1170 0 3066 28632
cpu  1170 0 3066 28634
cpu  1170 0 3067 28634
cpu  1171 0 3067 28634
cpu  1171 0 3067 28635 <<<
cpu  1171 0 3069 28634 <<<
cpu  1171 0 3070 28634 <<<
cpu  1171 0 3070 28635
cpu  1171 0 3070 28636
cpu  1172 0 3070 28637
cpu  1172 0 3071 28637

Or better yet, this hunter script:
#!/bin/sh
prev=0
while true; do cat /proc/stat; done | \
grep -F 'cpu  ' | \
cut -d ' ' -f 6 | \
while read next; do
    diff=$(($next-$prev))
    if test $diff -lt 0; then
        echo "$prev -> $next"
    fi
    prev=$next
done

It will print only 'bad' idle counter pairs
--
vda
