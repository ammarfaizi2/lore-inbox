Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQLSKDq>; Tue, 19 Dec 2000 05:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLSKDg>; Tue, 19 Dec 2000 05:03:36 -0500
Received: from pD9040345.dip.t-dialin.net ([217.4.3.69]:49163 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S129828AbQLSKDb>;
	Tue, 19 Dec 2000 05:03:31 -0500
Subject: 2.2.18: Thread problem with smbfs
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Dec 2000 10:33:41 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001219093341.E10DC3ED844@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hava a strange problem with smbfs. My application creates threads
that copy files from a mounted SMB share to the local disk. When
I run the application normally, there's no problem. However when
I run it in gdb 4.18 or 5.0, one of the threads goes into the D state
(not always), and the whole program including gdb hangs.

With strace, these are the last lines of output I get:

1854  sched_get_priority_max(0)         = 0
1854  sched_get_priority_min(0)         = 0
1854  brk(0x80ca000)                    = 0x80ca000
1854  pipe([9, 10])                     = 0
1854  clone()                           = 1856
1854  write(10, "\300\357\215@\5\0\0\0\24\364\377\277\256^\204@\370\377\215@\240\353\215@\276\271w@Q\270w@\274Dx@\240\353\215@Q\270w@\274Dx@\240\353\215@\260\357\215@\304\357\215@H\364\377\277\300\357\215@\370\377\215@\240\353\215@d\364\377\277\276\271w@\274Dx@\260\357\215@\256^\204@\370\377\215@\276\271w@\274Dx@\260\357\215@\2\0\0\0T\365\377\277G\200\0@>[w@\324Vf@D:\1@`R\216@\3\0\0\0p\365\377\277", 148) = 148
1854  rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
1854  write(10, "\0!x@\0\0\0\0\360\365\377\277\0 q@\340`\f\10\0\0\0\200\0\0\0\0\f\0\0\0P\357\22@\f\0\0\0l\365\377\277\\.d@\204\342\22@\354\215\371\7\234\365\377\277\"@f@\314\233\315\4\250\365\377\277\\.d@\240\365\377\277A\245\0@X\340\22@@R\216@\7\0\0\0\216\244\0@\370\227v@\340`\f\10P\234\v\10|\263d@H\236v@D;w@\24\366\377\277\360\246\0@\0 q@2\0\0\0p\232w@x\340\22@", 148) = 148
1854  rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
1854  rt_sigsuspend([] <unfinished ...>

In the syslog I find the following:

Dec 18 19:07:58 George kernel: smb_get_length: recv error = 512
Dec 18 19:07:58 George kernel: smb_trans2_request: result=-512, setting invalid
Dec 18 19:07:59 George kernel: smb_retry: sucessful, new pid=16002, generation=38
Dec 18 19:07:59 George kernel: smb_get_length: recv error = 512
Dec 18 19:07:59 George kernel: smb_trans2_request: result=-512, setting invalid
Dec 18 19:07:59 George kernel: smb_retry: sucessful, new pid=16002, generation=39
Dec 18 19:07:59 George kernel: smb_get_length: recv error = 512
Dec 18 19:07:59 George kernel: smb_trans2_request: result=-512, setting invalid
Dec 18 19:08:00 George kernel: smb_retry: sucessful, new pid=16002, generation=40

and so on, endlessly. So, AFAIK,  smbfs thinks it has lost connection and
tells smbmount to re-establish it, which succeeds (at least smbmount
thinks so). This happens several times per second.

However, with processes instead of threads, without the debugger, or
when reading from a local filesystem instead of a SMB filesystem, there
is no problem.

Kernel 2.2.18, smbfs as a module. I can provide more info if necessary.

Regards,
hjb
-- 
http://www.pro-linux.de/ - Germany's largest volunteer Linux support site
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
