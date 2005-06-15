Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVFOTlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVFOTlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFOTlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:41:15 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:44247 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261522AbVFOTlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:41:03 -0400
Date: Thu, 16 Jun 2005 04:40:45 +0900 (JST)
Message-Id: <20050616.044045.26507987.okuyamak@dd.iij4u.or.jp>
To: tytso@mit.edu
Cc: reiser@namesys.com, adilger@clusterfs.com, fs@ercist.iscas.ac.cn,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
       madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, matsui_v@valinux.co.jp,
       kikuchi_v@valinux.co.jp, fernando@intellilink.co.jp,
       kskmori@intellilink.co.jp, takenakak@intellilink.co.jp,
       yamaguchi@intellilink.co.jp, ext2-devel@lists.sourceforge.net,
       shaggy@austin.ibm.com, xfs-masters@oss.sgi.com,
       Reiserfs-Dev@namesys.com
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel
 summit
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20050615140105.GE4228@thunk.org>
References: <42AE1D4A.3030504@namesys.com>
	<42AE450C.5020908@dd.iij4u.or.jp>
	<20050615140105.GE4228@thunk.org>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ted-san, and all,

>>>>> "Ted" == Theodore Ts'o <tytso@mit.edu> writes:
Ted> Part of the problem is that we are limited by the constraints of the
Ted> POSIX specification for error handling.  For example, we don't have a
Ted> way of telling the application, "the reason why you the filesystem was
Ted> remounted-read-only was in reaction to an I/O error that appears to be
Ted> caused by the multiple CRC checksum errors reported by the SCSI
Ted> controller".  We can only return EIO or EROFS.  And while the write()
Ted> which causes an I/O error that remounts the filesystem read/only can
Ted> (and probably does) return EIO, any subsequent writes will return
Ted> EROFS, and changing this would be hard, hackish, and probably wouldn't
Ted> be accepted.


You said:

Ted> And while the write()
Ted> which causes an I/O error that remounts the filesystem read/only can
Ted> (and probably does) return EIO

No. they return EROFS from beginning.


Ted> We can only return EIO or EROFS.

I do understand about EIO. What I don't see is EROFS.
EROFS could be returned if file system is being mounted as r/o from
beginning.



The point is pretty easy ( I think ).

Q1.  Why does file system succeed in re-mounting as r/o, when device
     is totally lost?

If device did exist, and throwing away the dirty pages did succeed,
then unmount that device/mount them as read only, should succeed
too. If this is what's happening, EROFS is good result. I agree with
this.

But in case of Mr. Qu's test, device is lost. USB cabel is
unplugged. They are unreachable. How could such device be *MOUNTED*?
# In other word, why can't I mount device which does not exist,
# while I can re-mount them?



Ted> So instead of trying to standardize the existing error returns, which
Ted> are they way they are and for which trying to standardize them would
Ted> probably be not worth the effort, since they don't return enough
Ted> context to the application anyway

I'm sorry, but I can't agree with this.

When error arise from system call, what application first care is to
divide error into two types.

1) devices and file systems are still under control of kernel.
2) devices or file systems are not under control of kernel anymore.

In case of 1, application will wonder if application have done
something wrong ( including user mistakenly mounted filesystem r/o
when it should be r/w, or application writing to r/o file system ).

In case of 2, application can do nothing ( and so should be kernel
). It's human who have to decide what to do.
# usualy, it means "give up the data", but sometimes, you may
# have choice of writing that data to some other devices.

Once type 2 error arise, system should not go back to type 1.
It should be one way path.


EROFS is typically error of type 1.
EIO is typically type 2.
 (SIGBUS is typically type2 too. But is there any other type 2
  error? None that I know of. )

What I believe (I'm sorry, but this is only my believe) is, we
should not mix error of type 1 with error of type 2.  If type 2
problem arised, type 2 error should be passed to application.  The
mode should be one-way.

I do agree that, for devices, it is device driver's responsibility
to identify which type of error have arised. But when file system
recieved type 2 error, he should not change it to type 1 error
( unless fs could really guarantee that ).


And, therefore, for type 2, I belive they can be standardize, and I
think we should.

I strongly agree that, for type 1, there are many ways we can
handle. I agree how you treat type 1 error would be characteristics
of each file system. Standardizing type 1 error is (in most cases)
nonsense.


I hope, Mr. Qu is looking for same thing.

regards,
---- 
Kenichi Okuyama
