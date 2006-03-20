Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWCTDlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCTDlb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 22:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCTDlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 22:41:31 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:32845 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbWCTDla convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 22:41:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DzjbiDFXw0SfhwH8+5Ga4LUnbIpzY+q8Pmip1sjclmROgh8ECsIXWYtshfpeZMYezTCL7evb20GH+pCnA0lVugFqaBsXon5Uncb95H+x8ysUdm2Xp4myHkMNykA6C+NQeQeF7TFKSbpVDFVGggtqvxmqtFMbFM789YY/dwmpyFs=
Message-ID: <787b0d920603191941w1e0c0af6p63402d068b61b7a5@mail.gmail.com>
Date: Sun, 19 Mar 2006 22:41:30 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 05/23] proc: Simplify the ownership rules for /proc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:

> Currently in /proc if the task is dumpable all of files are owned by
> the tasks effective users.  Otherwise the files are owned by root.
> Unless it is the /proc/tgid>/ or /proc/tgid>/task/pid> directory
> in that case we always make the directory owned by the effective user.
>
> However the special case for directories is pointless except as a way
> to read the effective user, because the permissions on both of those
> directories are world readable, and executable.

Well, that's exactly how "top" gets the EUID. The code:

p->euid = sb.st_uid;       /* need a way to get real uid */
p->egid = sb.st_gid;       /* need a way to get real gid */

I sure hope this patch didn't slip by me somehow. Big proc changes
ought to get review by the maintainers of procps, gtop, gdb, and
probably a good number of packages that don't come to mind right now.
I'm lucky I spotted this while reading over old lwn.net stories.

> /proc/tgid>/status provides a much better way to read a processes
> effecitve userid, so it is silly to try to provide that on the directory.

The stat() call is cheap.

The status file is kind of nasty:

open()
read()
close()
parse vague ill-defined ASCII text using evil speed hacks

The procps code uses stat() for selection by EUID in some
cases, and for everything whenever the status file is not
needed for some other reason. The "top" program is quite
good about not opening the status file. Lots of profiling
showed that there would be a noticable performance difference.
