Return-Path: <linux-kernel-owner+w=401wt.eu-S932790AbXAKWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbXAKWsw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbXAKWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:48:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40522 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbXAKWsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:48:51 -0500
Date: Thu, 11 Jan 2007 14:48:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: dean gaudet <dean@arctic.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
Message-Id: <20070111144801.ef86c169.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701111431470.4980@twinlark.arctic.org>
References: <17827.22798.625018.673326@notabene.brown>
	<Pine.LNX.4.64.0701110245300.22043@twinlark.arctic.org>
	<20070111122127.5bcc0b0f.akpm@osdl.org>
	<Pine.LNX.4.64.0701111431470.4980@twinlark.arctic.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 14:35:06 -0800 (PST)
dean gaudet <dean@arctic.org> wrote:

> actually a global dirty_ratio causes interference between devices which 
> should otherwise not block each other...
> 
> if you set up a "dd if=/dev/zero of=/dev/sdb bs=1M" it shouldn't affect 
> write performance on sda -- but it does... because the dd basically 
> dirties all of the "dirty_background_ratio" pages and then any task 
> writing to sda has to block in the foreground...  (i've had this happen in 
> practice -- my hack fix is oflag=direct on the dd... but the problem still 
> exists.)

yeah.  Plus your heavy-dd-to-/dev/sda tends to block light-writers to
/dev/sda in perhaps disproportionate ways.

This is on my list of things to look at.  Hah.

> i'm not saying fixing any of this is easy, i'm just being a user griping 
> about it :)

It's rather complex, I believe.   Needs per-backing-dev dirty counts (already
in -mm) plus, I suspect, per-process dirty counts (possibly derivable from
per-task-io-accounting) plus some tricky logic to make all that work along
with global dirtiness (and later per-node dirtiness!) while meeting all the
constraints which that logic must satisfy.
