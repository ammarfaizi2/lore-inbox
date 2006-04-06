Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWDFDUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWDFDUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDFDUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:20:09 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:19159 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751348AbWDFDUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p2NCeVKn1F4ffvdDtMzUJ9NyDMnXf9Wfsw21JdA3rVtE+DBQ6AmaUkIdReLhw6EfC2iw9YIXim8q2Inh9nj2Sk8J1RsN+kQADJIfUEMAvB5RgGWWcWxOctO7IQ17ijr/9Coqx48uo3kC/eEm6BM3q0WHycAzr2o3ioYem/VuyZU=
Message-ID: <787b0d920604052020rdaa5146q58720e7fd82ce0bb@mail.gmail.com>
Date: Wed, 5 Apr 2006 23:20:07 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: ak@muc.de, ak@suse.de, linux-kernel@vger.kernel.org
Subject: 32-on-64 (x86-64) siginfo corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The situation:  32-bit debugger, 32-bit child, 64-bit kernel

The debugger sends an RT signal to the child. (to stop it, with
a queue and siginfo so that non-debugger signals don't get lost)
To do this, the debugger uses tgkill().

Later, the debugger checks the child's siginfo_t before discarding
it. This is to be sure that the child didn't get the RT signal from
some other source. The debugger fills a siginfo_t with 0xff, then
fetches siginfo data via ptrace. The data is corrupt:

FIELD     32-ON-64   NORMAL
si_pid      -1       getpid()
si_uid    getpid()   getuid()

The "getpid" and "getuid" above are done in the debugger, not in
the child. The si_code values are SI_TKILL.

Probably the other ports with 32-on-64 support ought to verify
that this stuff works right.
