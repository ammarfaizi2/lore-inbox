Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTDGP2x (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTDGP2x (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:28:53 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:60878 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263487AbTDGP2W (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:28:22 -0400
Subject: Same syscall is defined to different numbers on 3 different archs(was Re: Makefile
 issue)
To: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>,
       linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 7 Apr 2003 11:39:40 -0400
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 04/07/2003 11:39:43 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=0ABBE792DFC187218f9e8a93df938690918c0ABBE792DFC18721"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=0ABBE792DFC187218f9e8a93df938690918c0ABBE792DFC18721
Content-type: text/plain; charset=us-ascii


Sorry for the delay in response.....I was very busy with this month's
release.  I reviewed the testcase, and you have coded it the correct way
using __syscall.  I believe the problem is that we need to define
__NR_timer_create/delete in the test itself.  I tried this and the test
compiled and executed correctly.  However, I looked at the kernel, and it
seems that there is a BUG in the code....there are different numbers
assigned to the timer system calls for different archs:

# grep -r __NR_timer_create /usr/src/linux-2.5.66/include/*
/usr/src/linux-2.5.66/include/asm-i386/unistd.h:#define __NR_timer_create
        259
/usr/src/linux-2.5.66/include/asm-ppc/unistd.h:#define __NR_timer_create
240
/usr/src/linux-2.5.66/include/asm-ppc64/unistd.h:#define __NR_timer_create
240
/usr/src/linux-2.5.66/include/asm-x86_64/unistd.h:#define __NR_timer_create
222

 # grep -r __NR_timer_delete /usr/src/linux-2.5.66/include/*
/usr/src/linux-2.5.66/include/asm-i386/unistd.h:#define __NR_timer_delete
(__NR_timer_create+4)
/usr/src/linux-2.5.66/include/asm-ppc/unistd.h:#define __NR_timer_delete
244
/usr/src/linux-2.5.66/include/asm-ppc64/unistd.h:#define __NR_timer_delete
244
/usr/src/linux-2.5.66/include/asm-x86_64/unistd.h:#define __NR_timer_delete
226

Obviously, we could add additional code to check for the running arch and
define the syscall accordingly, however I'm not sure this is the correct
way to go.  I'm copying our list, as well as the kernel mailing list about
this, because I "think" the system calls should be defined to the same
numbers across all architectures....but I'm not positive.  BTW,  I attached
the testcase with my changes....which will only work on i386.

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

(See attached file: timer_delete01.c)(See attached file: Makefile)



                                                                                                                                       
                      "Aniruddha M                                                                                                     
                      Marathe"                  To:       Robert Williamson/Austin/IBM@IBMUS                                           
                      <aniruddha.marathe        cc:                                                                                    
                      @wipro.com>               Subject:  Makefile issue                                                               
                                                                                                                                       
                      04/03/2003 05:27                                                                                                 
                      AM                                                                                                               
                                                                                                                                       




Hi,
I am writing testcases for system calls that were recently added in the 2.5
versions of kernel. Since there are some new header files / added
definitions in other header files in 2.5 versions, I have to give something
like
-I/src/ (kernel that supports new definitions/include in makefile for clean
compilation.

I am attaching a test case for timer_delete(2) and a Makefile to give you
an exact idea of the problem.
Please see the makefile
Now if I remove  "-I/usr/src/linux-2.5.64/include" from CFLAGS, the
compilation will fail as:
timer_delete01.c: In function `timer_create':
timer_delete01.c:86: `__NR_timer_create' undeclared (first use in this
function)

Since I can't generalize any such path, these test cases will fail for
others. Note that its not issue of kernel version. I can check kernel
version with uname -r in makefile and then compile it (or do not compile
it). The issue is of path.

Can you suggest any way out?

Thanks,
Aniruddha.







#### Makefile has been removed from this note on April 07, 2003 by Robert
Williamson
#### timer_delete01.c has been removed from this note on April 07, 2003 by
Robert Williamson


--0__=0ABBE792DFC187218f9e8a93df938690918c0ABBE792DFC18721
Content-type: application/octet-stream; 
	name="timer_delete01.c"
Content-Disposition: attachment; filename="timer_delete01.c"
Content-transfer-encoding: base64

LyoKICogQ29weXJpZ2h0IChjKSBXaXBybyBUZWNobm9sb2dpZXMgTHRkLCAyMDAzLiAgQWxsIFJp
Z2h0cyBSZXNlcnZlZC4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKICogdW5kZXIgdGhlIHRlcm1zIG9m
IHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMKICogcHVibGlz
aGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCiAqCiAqIFRoaXMgcHJvZ3JhbSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdvdWxkIGJlIHVzZWZ1bCwgYnV0CiAq
IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkg
b2YKICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LgogKgogKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBhbG9uZwogKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0
ZSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLCA1OQogKiBUZW1wbGUgUGxhY2Ug
LSBTdWl0ZSAzMzAsIEJvc3RvbiBNQSAwMjExMS0xMzA3LCBVU0EuCiAqCiAqLwovKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioKICogCiAqICAgIFRFU1QgSURFTlRJRklFUgk6IHRpbWVyX2RlbGV0ZTAxIAogKiAK
ICogICAgRVhFQ1VURUQgQlkJOiBhbnlvbmUKICogCiAqICAgIFRFU1QgVElUTEUJOiBCYXNpYyB0
ZXN0IGZvciB0aW1lcl9kZWxldGUoMikKICogCiAqICAgIFRFU1QgQ0FTRSBUT1RBTAk6IDEKICog
CiAqICAgIEFVVEhPUgkJOiBBbmlydWRkaGEgTWFyYXRoZSA8YW5pcnVkZGhhLm1hcmF0aGVAd2lw
cm8uY29tPgogKiAKICogICAgU0lHTkFMUwogKiAJVXNlcyBTSUdVU1IxIHRvIHBhdXNlIGJlZm9y
ZSB0ZXN0IGlmIG9wdGlvbiBzZXQuCiAqIAkoU2VlIHRoZSBwYXJzZV9vcHRzKDMpIG1hbiBwYWdl
KS4KICoKICogICAgREVTQ1JJUFRJT04KICogICAgIFRoaXMgaXMgYSBQaGFzZSBJIHRlc3QgZm9y
IHRoZSB0aW1lcl9kZWxldGUoMikgc3lzdGVtIGNhbGwuCiAqICAgICBJdCBpcyBpbnRlbmRlZCB0
byBwcm92aWRlIGEgbGltaXRlZCBleHBvc3VyZSBvZiB0aGUgc3lzdGVtIGNhbGwuCiAqIAogKiAJ
U2V0dXA6CiAqCSAgU2V0dXAgc2lnbmFsIGhhbmRsaW5nLgogKgkgIFBhdXNlIGZvciBTSUdVU1Ix
IGlmIG9wdGlvbiBzcGVjaWZpZWQuCiAqIAogKiAJVGVzdDoKICoJIExvb3AgaWYgdGhlIHByb3Bl
ciBvcHRpb25zIGFyZSBnaXZlbi4KICoJIENyZWF0ZSBhIFBPU0lYIHRpbWVyCiAqCSBFeGVjdXRl
IHN5c3RlbSBjYWxsIAogKgkgQ2hlY2sgcmV0dXJuIGNvZGUsIGlmIHN5c3RlbSBjYWxsIGZhaWxl
ZCAocmV0dXJuPS0xKQogKgkJTG9nIHRoZSBlcnJubyBhbmQgSXNzdWUgYSBGQUlMIG1lc3NhZ2Uu
CiAqCSBPdGhlcndpc2UsIElzc3VlIGEgUEFTUyBtZXNzYWdlLgogKiAKICogCUNsZWFudXA6CiAq
IAkgIFByaW50IGVycm5vIGxvZyBhbmQvb3IgdGltaW5nIHN0YXRzIGlmIG9wdGlvbnMgZ2l2ZW4K
ICogCiAqIFVTQUdFOiAgPGZvciBjb21tYW5kLWxpbmU+CiAqIHRpbWVyX2RlbGV0ZTAxIFstYyBu
XSBbLWVdIFstaSBuXSBbLUkgeF0gWy1QIHhdIFstdF0gWy1wXQogKiB3aGVyZToKICogCS1jIG4g
OiBSdW4gbiBjb3BpZXMgc2ltdWx0YW5lb3VzbHkuIAogKgktZSAgIDogVHVybiBvbiBlcnJubyBs
b2dnaW5nLgogKgktaSBuIDogRXhlY3V0ZSB0ZXN0IG4gdGltZXMuCiAqCS1JIHggOiBFeGVjdXRl
IHRlc3QgZm9yIHggc2Vjb25kcy4KICoJLXAgICA6IFBhdXNlIGZvciBTSUdVU1IxIGJlZm9yZSBz
dGFydGluZwogKgktUCB4IDogUGF1c2UgZm9yIHggc2Vjb25kcyBiZXR3ZWVuIGl0ZXJhdGlvbnMu
CiAqCS10ICAgOiBUdXJuIG9uIHN5c2NhbGwgdGltaW5nLgogKgogKlJFU1RSSUNUSU9OUzoKICog
VGhpcyBzeXN0ZW0gY2FsbCBpcyBpbXBsZW1lbnRlZCBpbiBrZXJuZWwgMi41LjYzLiBUZXN0IGNh
c2Ugd2lsbCBicmVhayBmb3IgCiAqIEtlcm5lbCB2ZXJzaW9ucyBsZXNzIHRoYW4gMi41LjYzCiAq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KCiNpbmNsdWRlICJ0ZXN0LmgiCiNpbmNsdWRlICJ1c2N0ZXN0
LmgiCiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3lzY2FsbC5oPgojaW5jbHVkZSA8dGlt
ZS5oPgoKI2lmbmRlZiBDTE9DS19SRUFMVElNRQojZGVmaW5lIENMT0NLX1JFQUxUSU1FIDAKI2Vu
ZGlmCgojZGVmaW5lIF9fTlJfdGltZXJfY3JlYXRlIDI1OQojZGVmaW5lIF9fTlJfdGltZXJfZGVs
ZXRlIChfX05SX3RpbWVyX2NyZWF0ZSArIDQpCgpzdGF0aWMgdm9pZCBzZXR1cCAoKTsKc3RhdGlj
IHZvaWQgY2xlYW51cCAoKTsKCmNoYXIgKlRDSUQgPSAidGltZXJfZGVsZXRlMDEiOwkvKiBUZXN0
IHByb2dyYW0gaWRlbnRpZmllci4gICAgKi8KaW50IFRTVF9UT1RBTCA9IDE7CQkvKiBUb3RhbCBu
dW1iZXIgb2YgdGVzdCBjYXNlcy4gKi8KZXh0ZXJuIGludCBUc3RfY291bnQ7CQkvKiBUZXN0IENh
c2UgY291bnRlciBmb3IgdHN0Xyogcm91dGluZXMgKi8KdGltZXJfdCB0aW1lcl9pZDsKCl9zeXNj
YWxsMyAoaW50LCB0aW1lcl9jcmVhdGUsIGNsb2NraWRfdCwgd2hpY2hfY2xvY2ssIHN0cnVjdCBz
aWdldmVudCAqLAoJdGltZXJfZXZlbnRfc3BlYywgdGltZXJfdCAqLCB0aW1lcl9pZCk7Cl9zeXNj
YWxsMSAoaW50LCB0aW1lcl9kZWxldGUsIHRpbWVyX3QsIHRpbWVyX2lkKTsKCmludAptYWluIChp
bnQgYWMsIGNoYXIgKiphdikKewoJaW50IGxjLCBpOwkvKiBsb29wIGNvdW50ZXIgKi8KCWNoYXIg
Km1zZzsJLyogbWVzc2FnZSByZXR1cm5lZCBmcm9tIHBhcnNlX29wdHMgKi8KCglpZiAodHN0X2t2
ZXJjbXAgKDIsIDUsIDYzKSA8IDApIHsKCQl0c3RfYnJrbSAoVEJST0ssIHRzdF9leGl0LCAiVGhp
cyBzeXN0ZW0gY2FsbCBpcyBub3QgaW1wbGVtZW50ZWQiCgkJCQkiIGluIHRoZSBydW5uaW5nIGtl
cm5lbCB2ZXJzaW9uIik7Cgl9CgoJLyogcGFyc2Ugc3RhbmRhcmQgb3B0aW9ucyAqLwoJaWYgKCht
c2cgPSBwYXJzZV9vcHRzIChhYywgYXYsIChvcHRpb25fdCAqKSBOVUxMLCBOVUxMKSkgIT0gCgkJ
CShjaGFyICopIE5VTEwpIHsKCQl0c3RfYnJrbSAoVEJST0ssIHRzdF9leGl0LCAiT1BUSU9OIFBB
UlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7Cgl9CgoJLyogcGVyZm9ybSBnbG9iYWwgc2V0dXAgZm9y
IHRlc3QgKi8KCXNldHVwICgpOwoKCS8qIGNoZWNrIGxvb3Bpbmcgc3RhdGUgaWYgLWkgb3B0aW9u
IGdpdmVuICovCglmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HIChsYyk7IGxjKyspIHsKCgkJLyog
cmVzZXQgVHN0X2NvdW50IGluIGNhc2Ugd2UgYXJlIGxvb3BpbmcuICovCgkJVHN0X2NvdW50ID0g
MDsKCgkJZm9yIChpID0gMDsgaSA8IFRTVF9UT1RBTDsgaSsrKSB7CgoJCQkvKiBDcmVhdGUgYSBQ
b3NpeCB0aW1lciovCgkJCWlmKHRpbWVyX2NyZWF0ZShDTE9DS19SRUFMVElNRSwgTlVMTCwgJnRp
bWVyX2lkKSA8IDApIHsKCQkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAidGltZXJfY3JlYXRl
IgoJCQkJCSAgICAgICAJIiBmYWlsZWQiKTsKCQkJfQoKCQkJVEVTVCAodGltZXJfZGVsZXRlKHRp
bWVyX2lkKSk7CgoJCQlpZiAoVEVTVF9SRVRVUk4gPT0gLTEpIHsKCQkJCVRFU1RfRVJST1JfTE9H
IChURVNUX0VSUk5PKTsKCQkJCXRzdF9yZXNtIChURkFJTCwgInRpbWVyX2RlbGV0ZSgyKSBGYWls
ZWQgYW5kIgoJCQkJCQkiIHNldCBlcnJubyB0byAlZCIsIFRFU1RfRVJSTk8pOwoJCQl9IGVsc2Ug
ewoJCQkJdHN0X3Jlc20gKFRQQVNTLCAidGltZXJfZGVsZXRlKDIpIFBhc3NlZCIpOwoJCQl9CgkJ
fQkvKkVuZCBvZiBURVNUIENBU0UgTE9PUElORyAqLwoJfQkJLypFbmQgZm9yIFRFU1RfTE9PUElO
RyAqLwoKCS8qQ2xlYW4gdXAgYW5kIGV4aXQgKi8KCWNsZWFudXAgKCk7CgoJLypOT1RSRUFDSEVE
Ki8gCglyZXR1cm4gMDsKfQoKLyogc2V0dXAoKSAtIHBlcmZvcm1zIGFsbCBPTkUgVElNRSBzZXR1
cCBmb3IgdGhpcyB0ZXN0ICovCnZvaWQKc2V0dXAgKCkKewoJLyogY2FwdHVyZSBzaWduYWxzICov
Cgl0c3Rfc2lnIChOT0ZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKCgkvKiBQYXVzZSBpZiB0
aGF0IG9wdGlvbiB3YXMgc3BlY2lmaWVkICovCglURVNUX1BBVVNFOwp9CS8qIEVuZCBzZXR1cCgp
ICovCgovKgogKiBjbGVhbnVwKCkgLSBQZXJmb3JtcyBvbmUgdGltZSBjbGVhbnVwIGZvciB0aGlz
IHRlc3QgYXQKICogY29tcGxldGlvbiBvciBwcmVtYXR1cmUgZXhpdAogKi8KCnZvaWQKY2xlYW51
cCAoKQp7CgkvKgoJKiBwcmludCB0aW1pbmcgc3RhdHMgaWYgdGhhdCBvcHRpb24gd2FzIHNwZWNp
ZmllZC4KCSogcHJpbnQgZXJybm8gbG9nIGlmIHRoYXQgb3B0aW9uIHdhcyBzcGVjaWZpZWQuCgkq
LwoJVEVTVF9DTEVBTlVQOwoKCS8qIGV4aXQgd2l0aCByZXR1cm4gY29kZSBhcHByb3ByaWF0ZSBm
b3IgcmVzdWx0cyAqLwoJdHN0X2V4aXQgKCk7Cn0JLyogRW5kIGNsZWFudXAoKSAqLwoK

--0__=0ABBE792DFC187218f9e8a93df938690918c0ABBE792DFC18721
Content-type: application/octet-stream; 
	name="Makefile"
Content-Disposition: attachment; filename="Makefile"
Content-transfer-encoding: base64

Iw0KIyAgQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3Jw
LiwgMjAwMQ0KIw0KIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJl
ZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQojICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KIyAgdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IN
CiMgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQojDQojICBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCiMg
IGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJy
YW50eSBvZg0KIyAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQ
VVJQT1NFLiAgU2VlDQojICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4NCiMNCiMgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQojICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgIGlm
IG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUNCiMgIEZvdW5kYXRpb24sIEluYy4sIDU5
IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEzMDcgVVNBDQojDQoN
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIw0KIyBuYW1lIG9mIGZpbGUJOiBNYWtlZmlsZQkJCQkJCSAgIw0K
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjDQpDRkxBR1MrPQktV2FsbCAtSS4uLy4uLy4uLy4uL2luY2x1ZGUN
CkxERkxBR1MrPQktTC4uLy4uLy4uLy4uL2xpYiAtbGx0cA0KDQpTUkNTPSQod2lsZGNhcmQgKi5j
KQ0KVEFSR0VUUz0kKHBhdHN1YnN0ICUuYywlLCQoU1JDUykpDQoNCmFsbDogJChUQVJHRVRTKQ0K
DQokKFRBUkdFVFMpOiAkKFNSQ1MpDQoJJChDQykgLW8gJEAgJEAuYyAkKENGTEFHUykgJChMREZM
QUdTKQ0KDQppbnN0YWxsOiBhbGwNCglAc2V0IC1lOyBmb3IgaSBpbiAkKFRBUkdFVFMpOyBkbyBs
biAtZiAkJGkgLi4vLi4vLi4vYmluLyQkaSA7IGRvbmUNCg0KY2xlYW46DQoJcm0gLWYgJChUQVJH
RVRTKQ0KDQoNCg==

--0__=0ABBE792DFC187218f9e8a93df938690918c0ABBE792DFC18721--

