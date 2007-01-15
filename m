Return-Path: <linux-kernel-owner+w=401wt.eu-S1751515AbXAOVA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXAOVA5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbXAOVA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:00:57 -0500
Received: from agmk.net ([87.236.194.20]:4179 "EHLO mail.agmk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbXAOVA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:00:56 -0500
X-Greylist: delayed 1184 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 16:00:55 EST
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: proxy_pda was Re: What was in the x86 merge for .20
Date: Mon, 15 Jan 2007 21:41:02 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701152141.02403.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've reviewed the thread and can propose a solution.
Let's see e.g. the dev.s ( from fuse.ko ). Currently with gcc-4.2 we get:

fuse_req_init_context:
        movl    $_proxy_pda+8, %edx     #, tmp62
#APP
        movl %gs:8,%ecx #, ret__
#NO_APP
        movl    344(%ecx), %ecx # <variable>.fsuid, <variable>.fsuid
        movl    %ecx, 60(%eax)  # <variable>.fsuid, <variable>.in.h.uid
#APP
        movl %gs:8,%ecx #, ret__
#NO_APP
        movl    360(%ecx), %ecx # <variable>.fsgid, <variable>.fsgid
        movl    %ecx, 64(%eax)  # <variable>.fsgid, <variable>.in.h.gid
#APP
        movl %gs:8,%edx #, ret__
#NO_APP
        movl    164(%edx), %edx # <variable>.pid, <variable>.pid
        movl    %edx, 68(%eax)  # <variable>.pid, <variable>.in.h.pid
        ret

In this scenario gcc is explictly blocked by -fno-strict-aliasing
and massive %gs:8 reloads are present. If you fix aliasing violations
in kernel then you could use -fstrict-aliasing to get what you want.

fuse_req_init_context:
#APP
        movl %gs:8,%ecx #, ret__
#NO_APP
        movl    344(%ecx), %edx # <variable>.fsuid, <variable>.fsuid
        movl    %edx, 60(%eax)  # <variable>.fsuid, <variable>.in.h.uid
        movl    360(%ecx), %edx # <variable>.fsgid, <variable>.fsgid
        movl    %edx, 64(%eax)  # <variable>.fsgid, <variable>.in.h.gid
        movl    164(%ecx), %edx # <variable>.pid, <variable>.pid
        movl    %edx, 68(%eax)  # <variable>.pid, <variable>.in.h.pid
        ret

BR,
Pawel.
