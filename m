Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDYAtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTDYAtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:49:47 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:13820 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262853AbTDYAtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:49:46 -0400
Date: Fri, 25 Apr 2003 12:49:04 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: 2.4.21-pre1: Memory leak in buffer code?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051231664.1662.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This script seems to reveal a memory leak of some sort in the buffer
code. I have run it on the same filesystem mounted as both ext2 and ext3
under 2.4.21-pre1, and in both cases get decreasing free memory and
increasing buffers. The line which activates the problem is the echo
which is directed to testlog.

#!/bin/bash

RUN=1

while [ 1 ]; do
	MEMFREE=`head -2 /proc/meminfo | tail -1 | awk -F ' ' '{ print $4 }'`
	BUFFERS=`head -2 /proc/meminfo | tail -1 | awk -F ' ' '{ print $6 }'`
	echo -e -n "\rIteration $ITERATION. MemFree is $MEMFREE. Buffers is $BUFFERS"
	echo "Run $ITERATION beginning at `date`" > /testlog
	ITERATION=$(($ITERATION+1))
done

I think I can also shed some light on a possible area to look at. I
originally found the problem while examining what appeared to be a
memory leak in swsusp. I set things up to bug on a page allocation where
the memory leak seemed to occur, and the page allocation was being
called from __pollwait in fs/select.c.

Hope this is helpful.

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

