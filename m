Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVIWVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVIWVmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVIWVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:42:19 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:7720 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932069AbVIWVmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AdyxEN5LIE/xY6EYV8zgpbUn6TWJzoNOEH+C83W4b5FnFtg6VpuGb/eBVzm6f7WgRb9Ohc4TqOIH4VmU7wFt3jzlTtdhs6VmrfuRnTbINbhICOMnRsPyajAaGTkIsY5ddCAjOapd7n3KsiZ0UwP5ld+La/SFLeNlyMnEIhGB5wY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] lib/string.c cleanup
Date: Fri, 23 Sep 2005 23:44:25 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Oeser <ioe@informatik.tu-chemnitz.de>,
       Jason Thomas <jason@topic.com.au>,
       Matthew Hawkins <matt@mh.dropbear.id.au>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232344.26044.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 3 small cleanup patches for lib/string.c against 2.6.14-rc2-git3

The first patch does whitespace and CodingStyle cleanups. It removes some 
blank lines, removes some trailing whitespace, adds spaces after commas and 
a few similar changes.

The second patch removes a few pointless  register  keywords. register is 
merely a compiler hint that access to the variable should be optimized, but 
gcc (3.3.6 in my case) generates the exact same code with and without the 
keyword, and even if gcc did something different with register present I think 
it is doubtful we would want to optimize access to these variables - especially
since this is generic library code and there are supposed to be optimized 
versions in asm/ for anything that really matters speed wise.

The third patch removes a few pointless explicit casts. The first two hunks of 
the patch really belongs in patch 1, but I missed them on the first pass and 
instead of redoing all 3 patches I stuck them in this one.


One odd sideeffect of patch 1 is that gcc generates an object file that is 4 
bytes smaller with the patch applied, but it's not obvious to me how it 
manages this saving since the patch only makes whitespace changes. I tried 
doing an objdump -D of string.o before and after the patch and compared the 
output with diff, but that didn't reveal the cause of the 4 saved bytes - odd.
I've included the objdump diff below - as you can see it really shouldn't 
make any difference, but the fact remains that the sizes differ :
  juhl@dragon:~/download/kernel/linux-2.6.14-rc2-git3$ ls -l lib/string.o.orig
  -rw-r--r--  1 juhl users 60912 2005-09-23 22:25 lib/string.o.orig
  juhl@dragon:~/download/kernel/linux-2.6.14-rc2-git3$ ls -l lib/string.o
  -rw-r--r--  1 juhl users 60908 2005-09-23 23:05 lib/string.o


 Disassembly of section .text:

@@ -9,46 +9,46 @@
    3:  57                      push   %edi
    4:  89 d7                   mov    %edx,%edi
    6:  56                      push   %esi
-   7:  89 ce                   mov    %ecx,%esi
-   9:  31 c9                   xor    %ecx,%ecx
+   7:  31 d2                   xor    %edx,%edx
+   9:  89 ce                   mov    %ecx,%esi
    b:  53                      push   %ebx
    c:  31 db                   xor    %ebx,%ebx
    e:  83 ec 04                sub    $0x4,%esp
-  11:  85 f6                   test   %esi,%esi
+  11:  85 c9                   test   %ecx,%ecx
   13:  89 45 f0                mov    %eax,0xfffffff0(%ebp)
   16:  74 48                   je     60 <strnicmp+0x60>
   18:  8b 45 f0                mov    0xfffffff0(%ebp),%eax
   1b:  0f b6 1f                movzbl (%edi),%ebx
   1e:  47                      inc    %edi
-  1f:  0f b6 08                movzbl (%eax),%ecx
+  1f:  0f b6 10                movzbl (%eax),%edx
   22:  40                      inc    %eax
   23:  89 45 f0                mov    %eax,0xfffffff0(%ebp)
-  26:  84 c9                   test   %cl,%cl
+  26:  84 d2                   test   %dl,%dl
   28:  74 36                   je     60 <strnicmp+0x60>
   2a:  84 db                   test   %bl,%bl
   2c:  74 32                   je     60 <strnicmp+0x60>
-  2e:  38 d9                   cmp    %bl,%cl
+  2e:  38 da                   cmp    %bl,%dl
   30:  74 2a                   je     5c <strnicmp+0x5c>
-  32:  0f b6 c1                movzbl %cl,%eax
-  35:  89 ca                   mov    %ecx,%edx
+  32:  0f b6 c2                movzbl %dl,%eax
+  35:  89 d1                   mov    %edx,%ecx
   37:  f6 80 00 00 00 00 01    testb  $0x1,0x0(%eax)
   3e:  74 03                   je     43 <strnicmp+0x43>
-  40:  8d 51 20                lea    0x20(%ecx),%edx
+  40:  8d 4a 20                lea    0x20(%edx),%ecx
   43:  0f b6 c3                movzbl %bl,%eax
-  46:  89 d1                   mov    %edx,%ecx
-  48:  89 da                   mov    %ebx,%edx
+  46:  89 ca                   mov    %ecx,%edx
+  48:  89 d9                   mov    %ebx,%ecx
   4a:  f6 80 00 00 00 00 01    testb  $0x1,0x0(%eax)
   51:  74 03                   je     56 <strnicmp+0x56>
-  53:  8d 53 20                lea    0x20(%ebx),%edx
-  56:  38 d1                   cmp    %dl,%cl
-  58:  89 d3                   mov    %edx,%ebx
+  53:  8d 4b 20                lea    0x20(%ebx),%ecx
+  56:  38 ca                   cmp    %cl,%dl
+  58:  89 cb                   mov    %ecx,%ebx
   5a:  75 04                   jne    60 <strnicmp+0x60>
   5c:  4e                      dec    %esi
   5d:  75 b9                   jne    18 <strnicmp+0x18>
   5f:  90                      nop
   60:  83 c4 04                add    $0x4,%esp
-  63:  0f b6 d3                movzbl %bl,%edx
-  66:  0f b6 c1                movzbl %cl,%eax
+  63:  0f b6 c2                movzbl %dl,%eax
+  66:  0f b6 d3                movzbl %bl,%edx
   69:  5b                      pop    %ebx
   6a:  5e                      pop    %esi
   6b:  5f                      pop    %edi



Anyway, the patches have been compile tested, and a kernel with all 3 applied 
boots just fine with no observable defects.


-- 
Jesper Juhl <jesper.juhl@gmail.com>


