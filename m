Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUDAS7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUDAS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:59:45 -0500
Received: from holomorphy.com ([207.189.100.168]:6575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263062AbUDAS7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:59:37 -0500
Date: Thu, 1 Apr 2004 10:59:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401185928.GK791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, andrea@suse.de,
	linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <20040401103425.03ba8aff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401103425.03ba8aff.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:34:25AM -0800, Andrew Morton wrote:
> What is the Oracle requirement in detail?
> If it's for access to hugetlbfs then there are the uid= and gid= mount
> options.
> If it's for access to SHM_HUGETLB then there was some discussion about
> extending the uid= thing to shm, but nothing happened.  This could be
> resurrected.
> If it's just generally for the ability to mlock lots of memory then
> RLIMIT_MEMLOCK would be preferable.  I don't see why we'd need the sysctl
> when `ulimit -m' is available?  (Where is that patch btw?)

I don't speak for Oracle (obviously), but it's basically for non-root
users to get at the stuff. There's an issue with a few pieces of
userspace that drive the kernel's capability bits being nonstandard
and/or broken (out-of-date? I can't even find the stuff).

DB2 gets away with using the C capability libraries directly because
its launcher scripts are basically setuid, then it arranges to avoid
dropping the capabilities. This is actually not ideal even for DB2, and
other databases don't use analogous launching scripts able to do this.

The "right" way from the userspace angle is basically either pam_cap or
the mlock rlimit, so when you log in as the database user, you get the
capabilities and/or rlimits. I don't appear to be able to decipher
what's going on with pam_cap and I'm not entirely sure anyone else has
either. The mlock rlimits appear to have a more coherent userspace
support story, and are "supposed" to be there anyway. The implementation
just seems to be missing pieces.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> There are a couple of off-by-ones in there I've got fixes for below.

On Thu, Apr 01, 2004 at 10:34:25AM -0800, Andrew Morton wrote:
> Using the security framework is neat.  There are currently large spinlock
> contention problems in avc_has_perm_noaudit() which I suspect will make
> SELinux problematic in some server environments.  But I trust it is
> possible to disable SELinux in config while using Bill's security module?
> I guess we could live with sysctl which simply nukes CAP_IPC_LOCK, but it
> has to be the when-all-else-failed option, yes?

The module I wrote acts as one of a number of different alternative
security policies (choosable at compile-time, and even at runtime if
I'd figured out how to actually do loadable modules properly). The
entire callback infrastructure configures out, and choices of security
models configure each other out in turn. It's somewhat more general
than it has to be, and amounts to what's basically a semi-open security
model with the monotonic etc. properties of capabilities removed since
r/w fs access to /proc/sys/capabilities/* entails all others. In theory,
this could be used for other things (CAP_SYS_NICE and CAP_SYS_RAWIO
come to mind), though I'm not aware of any outcry for things like this
for any other capabilities but CAP_IPC_LOCK.

I guess I can say that I'm not actually very wild about the security
module I wrote myself (it was more of an isolation-from-the-core effort
than a thing I wanted in and of itself). Some pieces may be able to be
made safer for users with Steven's suggestions.


-- wli
