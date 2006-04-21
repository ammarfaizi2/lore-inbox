Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWDUOIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWDUOIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDUOIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:08:35 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2075 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932333AbWDUOIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:08:34 -0400
In-Reply-To: <84144f020604210632n62ee6eafs147be14b1f46b8f9@mail.gmail.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF5500FC25.13788C4B-ON42257157.004C98F0-42257157.004DB206@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 21 Apr 2006 16:08:38 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 21/04/2006 16:09:33
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When the file system is mounted the accounting information is retrieved
> > and a file system tree is created with the attribute files containing
> > the cpu information. The content of the files remains unchanged until a
> > new update is  made. An update can be triggered from user space through
> > writing 'something' into a special purpose update file.
>
> Why are you caching the data?

We had two problems:

The first one was, that the hardware interface for getting the data is very
expensive. We always get back the data for all LPARs and all cpus.
Therefore
we do not want to get the data every time an attribute file is read.

The second problem was, that we want to provide a consistent snapshot
of the hypervisor data for the user space application. The mechanism to
achieve that is that the application first reads the update file. If
the data is too old, it triggers an update. Then we get the new
hypervisor data and update the whole filesystem tree. Then the
application can read file for file all data it needs. After all data
is read and the application wants to have a consistent snapshot,
it has to read the update attribute again. If the time value has changed,
another process has triggered another update in the meantime.
In this case the application has repeat the whole process.

Currently we allow only one update per second.

Michael

