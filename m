Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSKFWA2>; Wed, 6 Nov 2002 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbSKFWA2>; Wed, 6 Nov 2002 17:00:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1675 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266157AbSKFWAY>;
	Wed, 6 Nov 2002 17:00:24 -0500
From: "Jay Vosburgh" <fubar@us.ibm.com>
Importance: Normal
Sensitivity: 
To: Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1DE2DE38.9228F1D8-ON88256C69.0076552C@boulder.ibm.com>
Date: Wed, 6 Nov 2002 15:06:45 -0700
Subject: [PATCH] 2.5.46: epoll_wait can return too many events 
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 11/06/2002 03:06:55 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=07BBE6FADFE5D3BC8f9e8a93df938690918c07BBE6FADFE5D3BC"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=07BBE6FADFE5D3BC8f9e8a93df938690918c07BBE6FADFE5D3BC
Content-type: text/plain; charset=us-ascii


      The logic in fs/eventpoll.c:ep_events_transfer() to bundle events can
return more than the requested number of events (because the event count is
only incremented for each bundle); this will scribble on memory beyond the
end of the user's buffer.  The fix is to test against the bundle size
(ebufcnt) plus the event count (eventcnt).

      Also, passing maxevents <= 0 to epoll_wait() causes the system to
lock up; the fix is to return EINVAL if maxevents is <= 0.

      -J


--- linux-2.5.46.orig/fs/eventpoll.c      Wed Nov  6 12:20:46 2002
+++ linux-2.5.46/fs/eventpoll.c     Wed Nov  6 12:48:08 2002
@@ -457,6 +457,9 @@
      DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d)\n",
                 current, epfd, events, maxevents, timeout));

+     if (maxevents <= 0)
+           return -EINVAL;
+
      /* Verify that the area passed by the user is writeable */
      if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct pollfd))))
            goto eexit_1;
@@ -1068,7 +1071,7 @@

      write_lock_irqsave(&ep->lock, flags);

-     for (eventcnt = 0, ebufcnt = 0; eventcnt < maxevents && !list_empty(lsthead);) {
+     for (eventcnt = 0, ebufcnt = 0; (ebufcnt + eventcnt) < maxevents && !list_empty(lsthead);) {
            struct epitem *dpi = list_entry(lsthead->next, struct epitem, rdllink);

            /* Remove the item from the ready list */

(See attached file: epoll-2.5.46-maxevent.patch)


--0__=07BBE6FADFE5D3BC8f9e8a93df938690918c07BBE6FADFE5D3BC
Content-type: application/octet-stream; 
	name="epoll-2.5.46-maxevent.patch"
Content-Disposition: attachment; filename="epoll-2.5.46-maxevent.patch"
Content-transfer-encoding: base64

LS0tIGxpbnV4LTIuNS40Ni5vcmlnL2ZzL2V2ZW50cG9sbC5jCVdlZCBOb3YgIDYgMTI6MjA6NDYg
MjAwMgorKysgbGludXgtMi41LjQ2L2ZzL2V2ZW50cG9sbC5jCVdlZCBOb3YgIDYgMTI6NDg6MDgg
MjAwMgpAQCAtNDU3LDYgKzQ1Nyw5IEBACiAJRE5QUklOVEsoMywgKEtFUk5fSU5GTyAiWyVwXSBl
dmVudHBvbGw6IHN5c19lcG9sbF93YWl0KCVkLCAlcCwgJWQsICVkKVxuIiwKIAkJICAgICBjdXJy
ZW50LCBlcGZkLCBldmVudHMsIG1heGV2ZW50cywgdGltZW91dCkpOwogCisJaWYgKG1heGV2ZW50
cyA8PSAwKQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCS8qIFZlcmlmeSB0aGF0IHRoZSBhcmVhIHBh
c3NlZCBieSB0aGUgdXNlciBpcyB3cml0ZWFibGUgKi8KIAlpZiAoKGVycm9yID0gdmVyaWZ5X2Fy
ZWEoVkVSSUZZX1dSSVRFLCBldmVudHMsIG1heGV2ZW50cyAqIHNpemVvZihzdHJ1Y3QgcG9sbGZk
KSkpKQogCQlnb3RvIGVleGl0XzE7CkBAIC0xMDY4LDcgKzEwNzEsNyBAQAogCiAJd3JpdGVfbG9j
a19pcnFzYXZlKCZlcC0+bG9jaywgZmxhZ3MpOwogCi0JZm9yIChldmVudGNudCA9IDAsIGVidWZj
bnQgPSAwOyBldmVudGNudCA8IG1heGV2ZW50cyAmJiAhbGlzdF9lbXB0eShsc3RoZWFkKTspIHsK
Kwlmb3IgKGV2ZW50Y250ID0gMCwgZWJ1ZmNudCA9IDA7IChlYnVmY250ICsgZXZlbnRjbnQpIDwg
bWF4ZXZlbnRzICYmICFsaXN0X2VtcHR5KGxzdGhlYWQpOykgewogCQlzdHJ1Y3QgZXBpdGVtICpk
cGkgPSBsaXN0X2VudHJ5KGxzdGhlYWQtPm5leHQsIHN0cnVjdCBlcGl0ZW0sIHJkbGxpbmspOwog
CiAJCS8qIFJlbW92ZSB0aGUgaXRlbSBmcm9tIHRoZSByZWFkeSBsaXN0ICovCg==

--0__=07BBE6FADFE5D3BC8f9e8a93df938690918c07BBE6FADFE5D3BC--

