Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVKRWE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKRWE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVKRWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:04:29 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:16080 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964816AbVKRWE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:04:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qG+o45nIpzJdjoHrOIC9orn9NSlZ2hdwtDKB3Q3a0dmo4aPVSQX8siDP50CS5eZVcGxv3T/WqDqKqPVjeelukA/unBSXVFYv7BhlSrFQa+sAhH+wUORbnw97vcYePmpaFln5G2Q38/7PDWxW8VB68fE3XRyvThNTi59m9sRrgqw=
Message-ID: <deb0cdf00511181404k70828875ged944bb3910069b5@mail.gmail.com>
Date: Fri, 18 Nov 2005 14:04:28 -0800
From: Jeff Johnson <jellofan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: linux 2.6.13.4 (snapgear-3.3.0) scripts/mod/modpost dumps core
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new at this, so hopefully this is OK.  I'm working on an embedded
system using snapgear-3.3.0 (linux 2.6.13.4).  The kernel build fails
when executing modpost -- it dumps core.  I have debugged the problem.
In modpost.c:buf_printf() appears the following code:
      len = vsnprintf(tmp, SZ, fmt, ap);
      if (buf->size - buf->pos < len + 1) {
          buf->size += 128;
          buf->p = realloc(buf->p, buf->size);
      }
      strncpy(buf->p + buf->pos, tmp, len + 1);

What I have discovered is that in my environment, in some cases the
output from vsnprintf() exceeds 128 characters.  So when the test for
"remaining space < len" fails, and the buf is realloc'ed, not enough
memory is allocated, and the subsequent strncpy overflows the buffer.

My solution was to change the assignment of buf->size as follows:
          buf->size += 128 * ((len/128)+1);

This will cause buf->size to increment by enough 128 byte blocks to
hold the string.  If it isn't important to increment in 128 byte
chunks, then I suppose you could just have:
          buf->size += SZ;

Thanks
Jeff
