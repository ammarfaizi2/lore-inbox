Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTEKQWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 12:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTEKQWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 12:22:51 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:55204 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261753AbTEKQWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 12:22:50 -0400
Date: Sun, 11 May 2003 12:32:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: "arjanv@redhat.com" <arjanv@redhat.com>
Cc: Ahmed Masud <masud@googgun.com>, Yoav Weiss <ml-lkml@unpatched.org>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305111234_MC3-1-3865-CD21@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjanv wrote:

> examle: pseudocode for the unlink syscall
> 
> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     return original_syscall(userfilename);
> }


  That code has another hole that nobody else has mentioned
yet: I can fill the audit log by trying to delete nonexistent files,
and if accused of trying to mount a DOS attack on the audit trail
I can reasonably claim that it was all an accident...

  How about:

long wrapped_unlink(char *userfilename)
{
        char name1[len], name2[len];
        long ret;

        copy_from_user(name1, userfilename, ...);
        ret = original_unlink(userfilename);
        copy_from_user(name2, userfilename, ...);

        if (strncmp(name1, name2, len))
                audit_log(name1, name2, UNLINK_NAME_CHANGED);
        if (ret == 0 && AUDIT_SUCCESS)
                audit_log(name1, name2, UNLINK_SUCCEEDED);
        if (ret == -EPERM && AUDIT_FAILURE)
                audit_log(name1, name2, UNLINK_FAILED);

        return ret;
}
