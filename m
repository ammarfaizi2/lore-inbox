Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUBFRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUBFRXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:23:25 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:21700 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265558AbUBFRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:23:04 -0500
To: root@chaos.analogic.com
Cc: "Hefty, Sean" <sean.hefty@intel.com>, Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
	<Pine.LNX.4.53.0402061150100.3862@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Feb 2004 09:23:00 -0800
In-Reply-To: <Pine.LNX.4.53.0402061150100.3862@chaos>
Message-ID: <52smhounpn.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Feb 2004 17:23:02.0156 (UTC) FILETIME=[DFB02CC0:01C3ECD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> If some major changes are being considered, I think it's
    Richard> time to get rid of the:

    Richard> do { } while(0) stuff that permiates a lot of MACROS and
    Richard> just use the { } as they were designed.

    Richard> Before everybody screams, think. It's perfectly correct
    Richard> to start a new "program unit" without a conditional
    Richard> expression.  You just add a curley-brace, then close the
    Richard> brace when you are though.

This is totally, totally wrong.  If you get rid of do { } while (0),
then you can't use the macro in an if statement.  Read any C FAQ for
details, or try the following:

    #define MAC(x) { x = x + 1; }

    int main() {
      int x = 0;

      if (1)
        MAC(x);
      else
        x = x - 1;
    }

I get the following (correct) error:

    $ gcc a.c
    a.c: In function `main':
    a.c:8: syntax error before "else"
    $ gcc --version
    gcc (GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-20)

because

    if (1)
        { x = x + 1 } ; /* <-- note semicolon
    else
        x = x - 1;

is not correct C.

By the way, it is possible to use parentheses and commas for some
simple macros, so for example the following is OK:

    #define MAC(x) ( x = x + 1, x = x * 2 )

    int main() {
      int x = 0;

      if (1)
        MAC(x);
      else
        x = x - 1;
    }

However I don't see anything wrong with the perfectly standard "do { }
while (0)" idiom.  Certainly if some compiler generates worse code for
that construct that just a plain { }, _that_ is a compiler bug that we
shouldn't have to work around.

 - Roland
