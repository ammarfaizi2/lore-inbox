Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVFMI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVFMI6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFMI6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:58:11 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:47629 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261437AbVFMI5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:57:45 -0400
Subject: [RFD] FS behavior (I/O failure) in kernel summit
From: fs <fs@ercist.iscas.ac.cn>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com, reiser@namesys.com
Content-Type: text/plain
Organization: iscas
Message-Id: <1118692436.2512.157.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 15:53:56 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, Andrew Morton, and all FS maintainers,

    I've posted email before, but received no response. So I send
another email in the hope of getting feedback from the community.
    From the HA application developer's perspective, we want a 
robust, stable, fast-error-responsive kernel. But the file system
seems to be a disappointment. 
  
  We want to make things clear:

1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
unplug), FS should
   a. shutdown the FS right now(XFS does this)
   b. try to make the media serve as long as possible(EXT3 remounts 
      read-only, cache is still valid for read)
   c. do not care, just print some kernel debugging info(EXT2 JFS 
      ReiserFS)

2) When I/O failure occurs, FS should
   a. give a unified error
   b. give errors according to the FS type

3) the returned errno should be
   a. real cause of failure, e.g. USB unplug returns EIO
   b. cause from FS, e.g. USB unplug made FS remount read-only,
      so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
      EROFS
   c. errno means nothing, you already get -1, that's enough

    Unfortunately, recent kernel FSes give mixed answers to the above
questions. As an end user/developer, this is really BAD! Also, there's
no correspondent docs/standard, 'de facto' standard varies for different
people.

    So, we propose 1)a 2)a 3)a as the right behavior. We really hope FS
maintainers can give us a unified answer on this issue, or AT LEAST 
positive feedback. If possible, have a discussion in the Kernel Summit.

P.S.: DOUBT has released test results for linux, Solaris, WinXP sp2.
      Refer to it, then you can know how we feel as a developer.

>     I'm taking part in the project DOUBT[1], and my sub-project
> focuses on the consistency and coherency of FS[2].
>     Several days ago, I posted a thread, titled "[RFD] What error
> should
> FS return when I/O failure occurs?"[3] The purpose of this RFD, is to 
> see whether the community has agreed on this subject. Unfortunately,
> NO!
> 
>     From my test results in [2], we can see different FS returns
> different error, or even no error. The community has several points,
> A) some results are caused by bugs, some are correct, some are
>    implementation compromise. errno is passed to VFS from lower layer,
>    no need to supply unified error type. User applications should
>    handle every error type or glibc can convert the types to specified
>    error type.
> B) the kernel should give unified error(i.e. errno should be the same
>    for each FS, and give the correct meaning). User applicatons should
>    handle specified error type/types.
> C) the errno that user gets can't provide enough info, so, there's no
>    need to tell. User application gets -1 from I/O syscalls, that's
>    enough, don't use errno. If user really have special needs, the 
>    kernel should use special mechanism to achieve the goal, e.g. add 
>    new functions to device drivers.
> D) ...
> 
>     From the user's perspective, B) seems to be the best, especially
> for HA purpose. But till now, we can't find any standards or
> constraints, so each FS implementaion uses 'de facto' way to return
> errno. This makes users confused. 
>     So, would you please have a discussion about this issue in Kernel
> Summit (June 11-18)? If yes, we users are really thankful for this
> discussion,so we can know how linux is designed for I/O error handling
> about FS; if not, that means errno is FS implementation dependent, we
> have to test our app for each FS. :(
> 
> P.S.: During the presentation of Kenichi Okuyama in Paris, Windows
> seems to detect every I/O failure immediately, even for async writes.
> This shows how proprietary software handles I/O failure.
> 
> [1] http://developer.osdl.jp/projects/doubt/
> [2]
> http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency/index.html
> [3] http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/0006.html
> 

regards,
----
Qu Fuping


