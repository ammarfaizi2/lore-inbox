Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWJPWwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWJPWwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWJPWwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:52:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:774 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161144AbWJPWwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:52:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gX5kknLC8Me5fIDtxndtQ1QREFZfe0odp6sPz8oMovhzYdY1xcf6fPomoJl/WFVvpeC/s987D4dZ7+ulg0iC0SrkXay3vaF3PHfo1UTAtzcUgHjQBjLLBigjhLufYB1mMBhsf9xUDyaq6lmlj+RSmoCBgQCcScH4u5RRRAggPWo=
Message-ID: <123917630610161552o3d71416yf3df76c49c3e7c22@mail.gmail.com>
Date: Mon, 16 Oct 2006 15:52:00 -0700
From: "Amit Choudhary" <amit2030@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: potential mem leak when system is low on memory
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was just scrubbing the kernel for checking the return ststus of
kmalloc(), and I saw at many places the following things. I just
wanted to report this.

1. If there are more than one kmalloc() calls in the same function,
and if kmalloc() returns NULL for one of them, then the memory
obtained from previous kmalloc() calls is not released.

Something like:

func()
{
    var1 = kmalloc(size);
    if (!var1)
         return -ENOMEM;

    var2 = kmalloc(size);
    if (!var2)
         return -ENOMEM;

/* mem  leak as var1 is not freed */

}

2. Sometimes, memory is allocated in a loop. So, if kmalloc() fails at
some point, memory allocated previously is not released.

func()
{
    for (i = 0; i < LENGTH; i++) {
            var1[i] = kmalloc(size);
            if (!var1[i])
                 return -ENOMEM;

/* mem leak as var1[0] to var1[i - 1] is not freed */

    }
}

So, already the system is running low on memory and on top of it there
are leaks.

-Amit
