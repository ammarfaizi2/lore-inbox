Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263853AbTCVT3y>; Sat, 22 Mar 2003 14:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263871AbTCVT3x>; Sat, 22 Mar 2003 14:29:53 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:42689 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S263853AbTCVT3p>;
	Sat, 22 Mar 2003 14:29:45 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221940.h2MJeml23812@csl.stanford.edu>
Subject: [CHECKER] race in 2.5.62/fs/exec.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 11:40:48 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if I'm missing something --- is the following a race?

           2.5.62/fs/exec.c:1013:search_binary_handler:
                        read_unlock(&binfmt_lock);
                        retval = fn(bprm, regs);
                        if (retval >= 0) {
                                put_binfmt(fmt);

binfmt_lock is released and then put_binfmt is called.  put_binfmt
seems to need locking:

    fs/exec.c:1022:search_binary_handle

                        read_lock(&binfmt_lock);
                        put_binfmt(fmt);
                        if (retval != -ENOEXEC)
                                break;
                        if (!bprm->file) {
                                read_unlock(&binfmt_lock);
                                return retval;
                        }


   2.5.62/fs/exec.c:151:sys_uselib:

                     error = fmt->load_shlib(file);
                        read_lock(&binfmt_lock);
                        put_binfmt(fmt);
                        if (error != -ENOEXEC)
                                break;
                }

Are these other locks redundant?  Or does put_binfmt need protection?
