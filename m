Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRFUT1U>; Thu, 21 Jun 2001 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265153AbRFUT1D>; Thu, 21 Jun 2001 15:27:03 -0400
Received: from sncgw.nai.com ([161.69.248.229]:21225 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265149AbRFUT0z>;
	Thu, 21 Jun 2001 15:26:55 -0400
Message-ID: <XFMail.20010621123002.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20010621123002:1037=_"
Date: Thu, 21 Jun 2001 12:30:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: do_select() improvement ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7.Linux:20010621123002:1037=_
Content-Type: text/plain; charset=us-ascii


This patch can improve do_select() ==> select() performance due :

1) the load from the fd bitmap is done every __NFDBITS instead of every bit.
        If You look at the BITS() macro You'll see that it's not cheap in terms
        of memory operations

2) if a sequential hole of __NFDBITS is found it'll be skipped without doing a
        bit by bit check




*** select.orig.c       Thu Jun 21 08:52:04 2001
--- select.c    Thu Jun 21 12:09:25 2001
***************
*** 164,171 ****
--- 164,172 ----
  {
        poll_table table, *wait;
        int retval, i, off;
        long __timeout = *timeout;
+       unsigned long bits;
 
        read_lock(&current->files->file_lock);
        retval = max_select_fd(n, fds);
        read_unlock(&current->files->file_lock);
***************
*** 186,194 ****
                        unsigned long mask;
                        struct file *file;
 
                        off = i / __NFDBITS;
!                       if (!(bit & BITS(fds, off)))
                                continue;
                        file = fget(i);
                        mask = POLLNVAL;
                        if (file) {
--- 187,202 ----
                        unsigned long mask;
                        struct file *file;
 
                        off = i / __NFDBITS;
!                       if (!(i & (__NFDBITS - 1))) {
!                               bits = BITS(fds, off);
!                               if (!bits) {
!                                       i += __NFDBITS;
!                                       continue;
!                               }
!                       }
!                       if (!(bit & bits))
                                continue;
                        file = fget(i);
                        mask = POLLNVAL;
                        if (file) {
 
                                                                               
                                             

                                                                             
                                             

- Davide


--_=XFMail.1.4.7.Linux:20010621123002:1037=_
Content-Disposition: attachment; filename="select.c.diff"
Content-Transfer-Encoding: base64
Content-Description: select.c.diff
Content-Type: application/octet-stream; name=select.c.diff; SizeOnDisk=918

KioqIHNlbGVjdC5vcmlnLmMJVGh1IEp1biAyMSAwODo1MjowNCAyMDAxCi0tLSBzZWxlY3QuYwlU
aHUgSnVuIDIxIDEyOjA5OjI1IDIwMDEKKioqKioqKioqKioqKioqCioqKiAxNjQsMTcxICoqKioK
LS0tIDE2NCwxNzIgLS0tLQogIHsKICAJcG9sbF90YWJsZSB0YWJsZSwgKndhaXQ7CiAgCWludCBy
ZXR2YWwsIGksIG9mZjsKICAJbG9uZyBfX3RpbWVvdXQgPSAqdGltZW91dDsKKyAJdW5zaWduZWQg
bG9uZyBiaXRzOwogIAogICAJcmVhZF9sb2NrKCZjdXJyZW50LT5maWxlcy0+ZmlsZV9sb2NrKTsK
ICAJcmV0dmFsID0gbWF4X3NlbGVjdF9mZChuLCBmZHMpOwogIAlyZWFkX3VubG9jaygmY3VycmVu
dC0+ZmlsZXMtPmZpbGVfbG9jayk7CioqKioqKioqKioqKioqKgoqKiogMTg2LDE5NCAqKioqCiAg
CQkJdW5zaWduZWQgbG9uZyBtYXNrOwogIAkJCXN0cnVjdCBmaWxlICpmaWxlOwogIAogIAkJCW9m
ZiA9IGkgLyBfX05GREJJVFM7CiEgCQkJaWYgKCEoYml0ICYgQklUUyhmZHMsIG9mZikpKQogIAkJ
CQljb250aW51ZTsKICAJCQlmaWxlID0gZmdldChpKTsKICAJCQltYXNrID0gUE9MTE5WQUw7CiAg
CQkJaWYgKGZpbGUpIHsKLS0tIDE4NywyMDIgLS0tLQogIAkJCXVuc2lnbmVkIGxvbmcgbWFzazsK
ICAJCQlzdHJ1Y3QgZmlsZSAqZmlsZTsKICAKICAJCQlvZmYgPSBpIC8gX19ORkRCSVRTOwohIAkJ
CWlmICghKGkgJiAoX19ORkRCSVRTIC0gMSkpKSB7CiEgCQkJCWJpdHMgPSBCSVRTKGZkcywgb2Zm
KTsKISAJCQkJaWYgKCFiaXRzKSB7CiEgCQkJCQlpICs9IF9fTkZEQklUUzsKISAJCQkJCWNvbnRp
bnVlOwohIAkJCQl9CiEgCQkJfQohIAkJCWlmICghKGJpdCAmIGJpdHMpKQogIAkJCQljb250aW51
ZTsKICAJCQlmaWxlID0gZmdldChpKTsKICAJCQltYXNrID0gUE9MTE5WQUw7CiAgCQkJaWYgKGZp
bGUpIHsK

--_=XFMail.1.4.7.Linux:20010621123002:1037=_--
End of MIME message
