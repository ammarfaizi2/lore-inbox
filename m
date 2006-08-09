Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWHIOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWHIOLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWHIOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:11:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6080 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750869AbWHIOLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:11:10 -0400
Date: Wed, 9 Aug 2006 15:11:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dmitry Mishin <dim@openvz.org>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
Message-ID: <20060809141100.GP29920@ftp.linux.org.uk>
References: <44D87907.6090706@sw.ru> <20060808203814.GO29920@ftp.linux.org.uk> <200608091115.12949.dim@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091115.12949.dim@openvz.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:15:12AM +0400, Dmitry Mishin wrote:
> Do you meant utimes(file, NULL)?
> But is it correct behaviour? Why then do you get -EPERM on utimes(file, smth) 
> if the file is append-only? And why do you get -EACCESS on utimes(file, 
> NULL), if this file is immutable?
> 
> Could you explain, why is it done so?

RTFPOSIX...

Short version:
	* immutable files are immutable, including metadata
	* append-only files may be touched (when you write to the end), which
means that you can touch them.  Which is what utimes(file, NULL) does.
	* you can not truncate append-only file, overwrite already written
data or set timestamps to arbitrary values.

That's where the difference between utimes(file, NULL) and utimes(file, p)
is - the former basically is a write-without-write ("touch foo") and the
latter directly assigns to timestamps.  Permissions needed for these are
obviously different.

Please, read POSIX/SuS when modifying behaviour of syscalls.  Really.
