Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVFMVyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVFMVyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVFMVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:52:59 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:12644 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261475AbVFMVv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:51:26 -0400
Message-ID: <42ADFFD5.1090905@suse.com>
Date: Mon, 13 Jun 2005 17:51:17 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: fs <fs@ercist.iscas.ac.cn>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com>
In-Reply-To: <42ADC99D.5000801@namesys.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> fs wrote:
> 
>>Dear Linus, Andrew Morton, and all FS maintainers,
>>
>>   I've posted email before, but received no response. So I send
>>another email in the hope of getting feedback from the community.
>>   From the HA application developer's perspective, we want a 
>>robust, stable, fast-error-responsive kernel. But the file system
>>seems to be a disappointment. 
>> 
>> We want to make things clear:
>>
>>1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
>>unplug), FS should
>>  a. shutdown the FS right now(XFS does this)
>>  b. try to make the media serve as long as possible(EXT3 remounts 
>>     read-only, cache is still valid for read)
>>  c. do not care, just print some kernel debugging info(EXT2 JFS 
>>     ReiserFS)
>>
>>2) When I/O failure occurs, FS should
>>  a. give a unified error
>>  b. give errors according to the FS type
>>
>>3) the returned errno should be
>>  a. real cause of failure, e.g. USB unplug returns EIO
>>  b. cause from FS, e.g. USB unplug made FS remount read-only,
>>     so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
>>     EROFS
>>  c. errno means nothing, you already get -1, that's enough
>>
>>   Unfortunately, recent kernel FSes give mixed answers to the above
>>questions. As an end user/developer, this is really BAD! Also, there's
>>no correspondent docs/standard, 'de facto' standard varies for different
>>people.
>>
> If you write a patch to implement 1a and 3a for reiserfs and reiser4 I
> will accept them.  2a is too vague for me to support --- I can only
> answer the question of whether error conditions are fs independent when
> it is regarding specified error conditions.  I suspect there are times
> when it needs to be fs dependent, but only a comprehensive review could
> answer to that.

[quote repositioned so it's not top-posted]

Hans -

These tests must have been run on a kernel prior to 2.6.10-rc1. The I/O
error code exhibits behavior similar to ext3, so (1b). There are still
kinks to be worked out, but it's definitely not the "throw up our arms
and give up" that it used to be.

Implementing behavior 1a for ext3 and reiserfs should be fairly trivial
- - it just means that tests to check if the filesystem is in an aborted
state ("shutdown" in xfs terms) need to added to the call path in some
places, and be moved earlier in others.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCrf/VLPWxlyuTD7IRAqN6AJ9InmmuRbhle00JiHgRyIfKkF6cMACffyim
rM1y80zO5AexaDWbzXrD5iA=
=qXFS
-----END PGP SIGNATURE-----
