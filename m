Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbSKPHXb>; Sat, 16 Nov 2002 02:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbSKPHXb>; Sat, 16 Nov 2002 02:23:31 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28932 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267242AbSKPHXa>;
	Sat, 16 Nov 2002 02:23:30 -0500
Date: Sat, 16 Nov 2002 08:30:23 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving "special" port numbers in the kernel ?
Message-ID: <20021116073023.GD553@alpha.home.local>
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uel9mbcyi.fsf@unix-os.sc.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 04:00:37PM -0800, Arun Sharma wrote:
> 
> One of the Intel server platforms has a magic port number (623) that
> it uses for remote server management. However, neither the kernel nor
> glibc are aware of this special port.
> 
> As a result, when someone requests a privileged port using
> bindresvport(3), they may get this port back and bad things happen.
 
The problem is that you want bindresvport() to fail and your bind() to
succeed, but bindresvport() calls bind(), so there's no way to distinguish
them.

But if you're willing to modify a bit your app and the kernel, at least there
would be a method. You could find a way to mark some ports "RESERVED", so that
bind() fails on them unless the socket has been set to SO_REUSEPORT. It's
unlikely that a caller of bindresvport() would set this flag on its socket.
But when you know you want this port for your app, you could explicitly set it.

This concept could be extended to reserve unprivileged ports. Eg, we could
mark 1521, 3128, ... reserved, so that only proper apps could bind on them,
and more importantly, connect() wouldn't use them.

Cheers,
Willy

