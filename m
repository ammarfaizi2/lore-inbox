Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753370AbWKLWaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbWKLWaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbWKLWaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:30:30 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:42913 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1753370AbWKLWa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:30:29 -0500
Date: Sun, 12 Nov 2006 17:30:24 -0500
From: Nick Orlov <bugfixer@list.ru>
Subject: 2.6.19-rc4-mm1: writev() _functional_ regression
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Mail-followup-to: Andrew Morton <akpm@osdl.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <20061112223024.GA4104@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Somewhere in between 2.6.18-mm3 and 2.6.19-rc4-mm1 writev() got screwed.
It does not accept zero-length segments anymore.

Bad thing that it is extremely easy to trigger (even w/o explicit writev calls).
For example the following innocent program will fail with 2.6.19-rc4-mm1:

======================
#include <string.h>
#include <fstream>

int main()
{
  char buf[1024];
  memset(buf, 'A', sizeof(buf));
  std::ofstream ofs("test");
  //ofs << 1 << '\n';
  ofs.write(buf, sizeof(buf));
  return 0;
}
======================


Here is the corresponding part if strace:

======================
open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = -1 EFAULT (Bad address)
close(3)                                = 0
======================


With 2.6.18-mm3 it works

======================
open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1024
close(3)                                = 0
======================


It works with 2.6.19-rc4-mm1 _if_ zero-length segments are eliminated
(by uncommenting ofs << 1 << '\n'):

======================
open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
writev(3, [{"1\n", 2}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1026
close(3)                                = 0
======================


Given that _all_ applications using C++ streams are potentially affected
I think it's better to preserve the previous behavior even if it is
something from "undefined behavior world" (or a plain bug).

The bug is quite dangerous (I was really close to wipe out my mp3 collection).

Please let me know if you want me to try any patches.

Thank you,
	Nick Orlov.
-- 
With best wishes,
	Nick Orlov.

