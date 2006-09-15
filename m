Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWIOSrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWIOSrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWIOSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:47:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:2242 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932183AbWIOSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:47:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LxYoC0jKAjRkupsuc89WC9uHdS2RCCBx4ElSLIK1U1uZ2yJoFL3Tz9DTDJ4wvKcAK/gmU6XYa5ze82QD3BlUU8Lp/QaUgzE1Eo9VlX5/j5ZKeTsfo8WEPWJvoAG0zzkrZ5kkvFGY0QcLn/lzE+PAy0EZ4StRxATkYYfpEkp6QdI=
Message-ID: <35a82d00609151147q1157343bg1e3ddbdf264119b7@mail.gmail.com>
Date: Fri, 15 Sep 2006 11:47:15 -0700
From: "Scott Baker" <smbaker@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Questions about Exportfs / kernel nfs server / dentrys (2.6.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to understand some code in exportfs. The particular code is
in find_exported_dentry. Here is some pseudocode from
find_exported_dentry. I've stripped out the error-checking code and
included invariants that describe what I believe is going on.

INPUT: struct dentry *pd
/* struct dentry *pd is a disconnected dentry that we want to connect.
* it was probably created with d_alloc_anon. Note that IS_ROOT(pd)
* is TRUE.
*/

/* call export ops to get parent of pd */
ppd = CALL(nops, get_parent)(pd);

/* call export ops to get name of pd */
CALL(nops, get_name)(ppd, nbuf, pd)

/* perform a lookup using the name we received. We know that pd is a
* child of ppd, and we know that pd's name is 'nbuf', so the lookup
* should succeed and return us a non-anonymous dentry.
*/
npd = lookup_one_len(nbuf, ppd, strlen(nbuf));
/* In my test run, pd != ndp. This is because pd is an anonymous dentry
* and npd is a non-anonymous one, containing a name. Code comments
* say this is alright.
*/

if (IS_ROOT(pd)) {
     /* something went wrong, we have to give up */
    break;
}

The function is failing for me on that last IS_ROOT check in the if
statement. What I'm confused about is when was pd supposed to have
gone from unconnected to connected? In my test runs, npd is connected
but pd is not. They both have the same inode number. They both point
to the same inode.

Thanks,
Scott
