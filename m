Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVCOShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVCOShW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCOShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:37:21 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:46583 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261741AbVCOS14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:27:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=TtkiF+EgZOpQAo45RokuHif6yyXeZ4HWKbA8f74JFUE0VoY3mM7Jr5hBV2ei6yMRItKG/1S1KL9eE1VeqA1wJ0o/shayQDAfNTakDHvhItTPA5LJrrWqD7eLl6kmy1rnBQZBg87afy6Zp1NfTuLsnoGNPboIieYsOKr/MNFei5s=
Message-ID: <26092d8c0503151027ec75b63@mail.gmail.com>
Date: Tue, 15 Mar 2005 13:27:47 -0500
From: Artem Frolov <artemfrolov@gmail.com>
Reply-To: Artem Frolov <artemfrolov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Taking strlen of buffers copied from userspace
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am in the process of testing static defect analyzer on a Linux
kernel source code (see disclosure below).

I found some potential array bounds violations. The pattern is as
follows: bytes are copied from the user space and then buffer is
accessed on index strlen(buf)-1. This is a defect if user data start
from 0. So the question is: can we make any assumptions what data may
be received from the user or it could be arbitrary?

For example, in ./drivers/block/cciss.c, function cciss_proc_write
(line numbers are taken form 2.6.11.3):
   ....
   293          if (count > sizeof(cmd)-1) return -EINVAL;
   294          if (copy_from_user(cmd, buffer, count)) return -EFAULT;
   295          cmd[count] = '\0';
   296          len = strlen(cmd);      // above 3 lines ensure safety
   297          if (cmd[len-1] == '\n')
   298                  cmd[--len] = '\0';
   .....

Another example is arch/i386/kernel/cpu/mtrr/if.c, function mtrr_write:
   ....
   107          if (copy_from_user(line, buf, len - 1))
   108                  return -EFAULT;
   109          ptr = line + strlen(line) - 1;
   110          if (*ptr == '\n')
   111                  *ptr = '\0';
    ....


Full disclosure: I am working for Klocwork (http://www.klocwork.com/),
which is a vendor of commercial closed-source proprietary products,
static analyzer for C/C++ is part of its products

Best regards
--
Artem Frolov
Senior software engineer
Klocwork inc
