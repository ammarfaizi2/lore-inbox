Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWGYGrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWGYGrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWGYGrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:47:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3894 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751465AbWGYGrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:47:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G/ONuJ2w2khvOCUENBB3Y56mtx/0ovmLGR+s02OxklcL3eJw9aKq6aOLsA1kblPPYikTNh4ZMIoZj5D/VU/DY8sfVSRtV/dymYfVI1yjsadQp4vLdapNcuUFUDmD2iP8oQaKpIfT7NMGuQV2MBOBjpoHBmMpVwh+tPPDUb2a3YU=
Message-ID: <787b0d920607242347r3fabe43fr66adf2d53cd7aa11@mail.gmail.com>
Date: Tue, 25 Jul 2006 02:47:18 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, pj@sgi.com, akpm@osdl.org
Subject: Re: [RFC] ps command race fix
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

>> Hi, this is an experimental patch for the probelm
>>      - "ps command can miss some pid occationally"
...
> So I think we're still seeking a solution to this.

We have a solution, subject to some bit rot I'm sure.
The cookie/cursor hack should have been rejected.
I'm still wondering why that ever got accepted.

Hugh had a patch set containing a tree-based replacement
for the PID handling. It worked perfectly, letting /proc
look up the lowest-not-under PID for any given PID.

(can anybody find the patch set?)

BTW, here's a WONTFIX resolved bug that places the date
for the patch set as being prior to 2005-05-21.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=158277

> Options might be:
>
> a) Pin the most-recently-visited task in some manner, so that it is
>    still on the global task list when we return.  That's fairly simple to
>    do (defer the release_task()) but it affects task lifetime and visibility
>    in rare and worrisome ways.

In state X perhaps?

> b) Change proc_pid_readdir() so that it walks the pid_hash[] array
>    instead of the task list.  Need to do something clever when traversing
>    each bucket's list, but I'm not sure what ;) It's the same problem.
>
>    Possibly what we could do here is to permit the task which is walking
>    /proc to pin a particular 'struct pid': take a ref on it then when we
>    next start walking one of the pid_hash[] chains, we _know_ that the
>    'struct pid' which we're looking for will still be there.  Even if it
>    now refers to a departed process.

Well, we have to pin something if we don't use a tree.

If I remember right the cookie/cursor thing was mostly intended
to solve real-time problems. Obviously it fails at this too.
(not that attackable hashes are acceptable for real-time!)

> c) Nuke the pid_hash[], convert the whole thing to a radix-tree.
>    They're super-simple to traverse.  Not sure what we'd index it by
>    though.

With the right kind of tree, you just look up by PID and get
back the nearest result which is not less than the desired one.
This is what the older patch set did.

I like trees. They have nice cache properties. Decent trees are
immune to being turned into linked lists via hash function attacks.
The non-crypto hashes in the kernel ought to worry people.
