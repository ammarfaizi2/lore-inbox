Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266953AbUBSIKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbUBSIKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:10:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:1414 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266953AbUBSIKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:10:34 -0500
Date: Thu, 19 Feb 2004 08:10:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219081027.GB4113@mail.shareable.org>
References: <Pine.LNX.4.58.0402171859570.2686@home.osdl.org> <4032D893.9050508@zytor.com> <Pine.LNX.4.58.0402171919240.2686@home.osdl.org> <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >  > Why do you focus on linear directory scans?
> > 
> > Because a large number of file operations are on filenames that don't
> > exist. I have to *prove* they don't exist.
> 
> And you only need to do that ONCE per name.
> 
> There is zero reason to do it over and over again, and there is zero 
> reason to push case insensitivity deep into the filesystem.

Linus, while I agree with you wholeheartedly on everything else in
this thread - how can Samba only do that lookup ONCE per name if a
client is issuing many requests for non-existent opens or stats?

Example: A client has a search path for executables or libraries.

Each time SomeThing.DLL is looked up by the client, it will issue an
open() for each entry in the path, until it finds the file it wants.

For each request, Samba must readdir() every directory in the path
until the file is found.

If a directory doesn't change between requests, Samba can use dnotify
to cache the negative lookups.

However, if any change occurs in a directory, or if the directory is
not dnotify-capable, Samba is not allowed to cache these negative
results: It has to do the readdir() for _every_ request.

-- Jamie
