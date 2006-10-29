Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWJ2SeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWJ2SeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWJ2SeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:34:07 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:10333 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932374AbWJ2SeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:34:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=0tmPLn6oSqwAixK/zY3BpBhknLCgPr7hDmOIJfdp+6yk4qJGA9+eNiwSCHSzH1FAh9EapScBG+gCmaoPW1zatnQ7zmT1fhvUZkgRSTJVl6u5BY4DTWr/fjC+I1EwdC0jIfS+XA6mjTGsHZ6IYjhIPH541uUKK2Vl19q+gAE61a0=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] Fix "Remove the use of _syscallX macros in UML"
Date: Sun, 29 Oct 2006 19:34:05 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix commit 5f4c6bc1f369f20807a8e753c2308d1629478c61: it spits out warnings about
missing syscall prototype (it is in <unistd.h>) and it does not recognize that
two uses of _syscallX are to be resolved against kernel headers in the source
tree, not against _syscallX; they in fact do not compile and would not work
anyway.

If _syscallX macros will be removed from the kernel tree altogether, the only
reasonable solution for that piece of code is switching to open-coded inline
assembly (it's remapping the whole executable from memory, except the page
containing this code).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/sys-i386/tls.c |    3 +++
 arch/um/os-Linux/tls.c          |    1 +
 arch/um/sys-i386/unmap.c        |   11 +++++++----
 arch/um/sys-x86_64/unmap.c      |   11 +++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/um/os-Linux/sys-i386/tls.c b/arch/um/os-Linux/sys-i386/tls.c
index 6e945ab..2565320 100644
--- a/arch/um/os-Linux/sys-i386/tls.c
+++ b/arch/um/os-Linux/sys-i386/tls.c
@@ -1,6 +1,9 @@
 #include <errno.h>
 #include <linux/unistd.h>
+
 #include <sys/syscall.h>
+#include <unistd.h>
+
 #include "sysdep/tls.h"
 #include "user_util.h"
 
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index a2de258..9f7999f 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/ptrace.h>
 #include <sys/syscall.h>
+#include <unistd.h>
 #include <asm/ldt.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
diff --git a/arch/um/sys-i386/unmap.c b/arch/um/sys-i386/unmap.c
index 8e55cd5..1b0ad0e 100644
--- a/arch/um/sys-i386/unmap.c
+++ b/arch/um/sys-i386/unmap.c
@@ -5,17 +5,20 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
-#include <sys/syscall.h>
 
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if (syscall(__NR_munmap, to, size) < 0){
+	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if (syscall(__NR_mmap2, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
-	if (syscall(__NR_munmap, from, size) < 0){
+	if(munmap(from, size) < 0){
 		return(-1);
 	}
 	return(0);
diff --git a/arch/um/sys-x86_64/unmap.c b/arch/um/sys-x86_64/unmap.c
index 57c9286..f4a4bff 100644
--- a/arch/um/sys-x86_64/unmap.c
+++ b/arch/um/sys-x86_64/unmap.c
@@ -5,17 +5,20 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
-#include <sys/syscall.h>
 
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if (syscall(__NR_munmap, to, size) < 0){
+	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if (syscall(__NR_mmap, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
-	if (syscall(__NR_munmap, from, size) < 0){
+	if(munmap(from, size) < 0){
 		return(-1);
 	}
 	return(0);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
