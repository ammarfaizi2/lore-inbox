Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLPQ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLPQ1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVLPQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:27:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2756 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932341AbVLPQ1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:27:08 -0500
Message-ID: <43A2EA55.9070602@redhat.com>
Date: Fri, 16 Dec 2005 08:24:53 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Jim Meyering <meyering@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>	 <43A20B0B.5090205@pobox.com> <eeb5c3c50512160332v3f026766w2c954f1482e84616@mail.gmail.com>
In-Reply-To: <eeb5c3c50512160332v3f026766w2c954f1482e84616@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Meyering wrote:
> FYI, the rm in coreutils-cvs is finally thread-safe and race-free,
> when using openat et al.

Actually, Jim, I doubt it.  There is one more race which cannot be 
solved with the existing interfaces.  I want to tackle this next, after 
these changes are decided on.

The problem is directory creation and then populating it.  As in cp -r 
and any backup tool.  You currently have to use (at best)

    mkdirat(fd, "some-dir", 0666);
    dfd = openat(fd, "some-dir", O_RDONLY);

What is needed is a way to create a new directory and return a file 
descriptor for it.

I was thinking about using

dfd = openat(fd, "some-dir", O_RDONLY|O_DIRECTORY|O_CREAT, S_IFDIR|0666)

where the combination of using O_DIRECTORY, O_RDONLY, O_CREAT, and the 
S_IFDIR flag can be recognized.  This is a configuration which cannot be 
used successfully in current code.  Should probably also work with open().

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
