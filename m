Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263632AbUD0BBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUD0BBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUD0BBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:01:44 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:34759 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263632AbUD0BBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:01:41 -0400
Date: Tue, 27 Apr 2004 11:00:11 +1000
From: Nathan Scott <nathans@sgi.com>
To: Szima G?bor <sygma@tesla.hu>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS fsync() doesn't work under 2.4.26
Message-ID: <20040427110011.A604510@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.50.0404231702410.1163-100000@vigo.sygma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.50.0404231702410.1163-100000@vigo.sygma.net>; from sygma@tesla.hu on Fri, Apr 23, 2004 at 05:41:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 05:41:52PM +0200, Szima G?bor wrote:
> 
> Hi,

Hi there.

> fsync() take no effect on XFS filesystem under Linux kernel 2.4.26.

I'll look into it.  Note your test below isn't quite showing that;
what you want to do is do your writes, fsync, and then immediately
pull the plug on fsync completion - if all the data isn't on disk,
or the updates to the inode itself haven't been completed, then we
have a problem (barring write caching caveats, etc).

Having said that, the XFS flush time there seems too small - I'll
audit the code and run tests to check if we're flushing everything
out we that we should be.

> Simple open-write-fsync-close test:
> 
> ltrace -t /tmp/synctest:
> ...
>   0.002144 write(3, "", 1048576)                  = 1048576
>   0.002150 write(3, "", 1048576)                  = 1048576
>   0.002154 fsync(3, 0xbfeff684, 0x00100000, 0, 0) = 0
>   0.015962 close(3)                               = 0
>   ^^^^^^^^
> 
> (64 x 1 MB data, ~8 MB/s disk write speed)
> 
> 
> Under 2.4.25 or on other fs working fine:

Are you saying here that XFS on 2.4.25 shows this larger time,
as well as another filesystem?  (i.e. just 2.4.26 XFS differs?)

> ...
>   0.002149 write(3, "", 1048576)                  = 1048576
>   0.002744 write(3, "", 1048576)                  = 1048576
>   0.002188 fsync(3, 0xbfeff664, 0x00100000, 0, 0) = 0
>   8.048844 close(3)                               = 0
>   ^^^^^^^^

thanks.

-- 
Nathan
