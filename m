Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWG0RVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWG0RVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWG0RVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:21:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751826AbWG0RVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:21:46 -0400
Message-ID: <44C8F607.7070704@redhat.com>
Date: Fri, 28 Jul 2006 01:21:11 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia-Pacific
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eugene Teo <eteo@redhat.com>
Subject: Re: Require mmap handler for a.out executables
References: <1153909881.746.39.camel@localhost> <20060727150737.GA29521@infradead.org>
In-Reply-To: <20060727150737.GA29521@infradead.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
>> index f312103..5638acf 100644
>> --- a/fs/binfmt_aout.c
>> +++ b/fs/binfmt_aout.c
>> @@ -278,6 +278,9 @@ static int load_aout_binary(struct linux
>>  		return -ENOEXEC;
>>  	}
>>  
>> +	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
>> +		return -ENOEXEC;
>> +
> 
> These checks need a big comment explanining why they are there, else people
> will remove them again by accident.

Here's a resend.

Like what Marcel wrote, Andrew, please include this patch in -mm for testing.
Thanks.

Eugene
--

[PATCH] Require mmap handler for a.out executables

Files supported by fs/proc/base.c, i.e. /proc/<pid>/*, are not capable
of meeting the validity checks in ELF load_elf_*() handling because they
have no mmap handler which is required by ELF. In order to stop a.out
executables being used as part of an exploit attack against /proc-related
vulnerabilities, we make a.out executables depend on ->mmap() existing.

Signed-off-by: Eugene Teo <eteo@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index f312103..2042dfa 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -278,6 +278,12 @@ static int load_aout_binary(struct linux
                return -ENOEXEC;
        }

+       /* Requires a mmap handler. This prevents people from using a.out
+        * as part of an exploit attack against /proc-related vulnerabilities.
+        */
+       if (!bprm->file->f_op || !bprm->file->f_op->mmap)
+               return -ENOEXEC;
+
        fd_offset = N_TXTOFF(ex);

        /* Check initial limits. This avoids letting people circumvent
@@ -476,6 +482,12 @@ static int load_aout_library(struct file
                goto out;
        }

+       /* Requires a mmap handler. This prevents people from using a.out
+        * as part of an exploit attack against /proc-related vulnerabilities.
+        */
+       if (!file->f_op || !file->f_op->mmap)
+               goto out;
+
        if (N_FLAGS(ex))
                goto out;

-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
