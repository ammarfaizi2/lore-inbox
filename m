Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTENCFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbTENCFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:05:47 -0400
Received: from holomorphy.com ([66.224.33.161]:39615 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263722AbTENCFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:05:46 -0400
Date: Tue, 13 May 2003 19:18:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
Message-ID: <20030514021826.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Shawn <core@enodev.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <1052866461.23191.4.camel@www.enodev.com> <20030514012731.GF8978@holomorphy.com> <1052877161.3569.17.camel@www.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052877161.3569.17.camel@www.enodev.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:52:41PM -0500, Shawn wrote:
> execve("/bin/rpm", ["rpm", "-qi", "iptables"], [/* 32 vars */]) = 0
> uname({sys="Linux", node="www.enodev.com", ...}) = 0
> brk(0)                                  = 0x8069000
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=82290, ...}) = 0
[...]


okay, the first thing I see is:

-getgid32()                              = 500
-getuid32()                              = 500
+getgid32()                              = 0
+getuid32()                              = 0
 stat64("/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
 stat64("/var/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
 stat64("/var/lib/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
 stat64("/var/lib/rpm", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
-access("/var/lib/rpm", W_OK)            = -1 EACCES (Permission denied)
+access("/var/lib/rpm", W_OK)            = 0
+access("/var/lib/rpm/__db.001", F_OK)   = 0
+access("/var/lib/rpm/Packages", F_OK)   = 0

They appear to either not be running in equivalent environments or
something has gone horribly wrong. The diff is incredibly noisy and not
useful for debugging, could you strace the working kernel's bit as root?

Also, things start getting wildly different after both examine DB_CONFIG,
where 2.4 and 2.5 open different files with different options, i.e. 2.5
does O_DIRECT on /var/lib/rpm/__db.001 and 2.4 never touches that file,
and 2.4 never does O_DIRECT either.

This may very well have something to do with the difference in
privileges.


-- wli
