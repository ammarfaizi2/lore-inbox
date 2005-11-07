Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVKGW4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVKGW4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbVKGW4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:56:13 -0500
Received: from admingilde.org ([213.95.32.146]:45961 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S964901AbVKGW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:56:08 -0500
Message-Id: <20051107225604.841433000@admingilde.org>
References: <20051107225408.911193000@admingilde.org>
Date: Mon, 07 Nov 2005 23:54:10 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/4] DocBook: allow to mark structure members private
Content-Disposition: inline; filename=docbook-private-struct-members.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: allow to mark structure members private

Many structures contain both an internal part and one which is part of the
API to other modules.  With this patch it is possible to only include
these public members in the kernel documentation.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 include/linux/usb.h |    6 +++---
 scripts/kernel-doc  |   13 +++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-docbook/scripts/kernel-doc
===================================================================
--- linux-docbook.orig/scripts/kernel-doc	2005-11-04 22:55:27.236188385 +0100
+++ linux-docbook/scripts/kernel-doc	2005-11-04 23:13:29.348626536 +0100
@@ -117,6 +117,8 @@ use strict;
 # struct my_struct {
 #     int a;
 #     int b;
+# /* private: */
+#     int c;
 # };
 #
 # All descriptions can be multiline, except the short function description.
@@ -1304,6 +1306,12 @@ sub dump_struct($$) {
 	# ignore embedded structs or unions
 	$members =~ s/{.*?}//g;
 
+	# ignore members marked private:
+	$members =~ s/\/\*.*?private:.*?public:.*?\*\///gos;
+	$members =~ s/\/\*.*?private:.*//gos;
+	# strip comments:
+	$members =~ s/\/\*.*?\*\///gos;
+
 	create_parameterlist($members, ';', $file);
 
 	output_declaration($declaration_name,
@@ -1329,6 +1337,7 @@ sub dump_enum($$) {
     my $x = shift;
     my $file = shift;
 
+    $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     if ($x =~ /enum\s+(\w+)\s*{(.*)}/) {
         $declaration_name = $1;
         my $members = $2;
@@ -1365,6 +1374,7 @@ sub dump_typedef($$) {
     my $x = shift;
     my $file = shift;
 
+    $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     while (($x =~ /\(*.\)\s*;$/) || ($x =~ /\[*.\]\s*;$/)) {
         $x =~ s/\(*.\)\s*;$/;/;
 	$x =~ s/\[*.\]\s*;$/;/;
@@ -1420,7 +1430,7 @@ sub create_parameterlist($$$) {
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*)$param/$1/;
 	    push_parameter($param, $type, $file);
-	} else {
+	} elsif ($arg) {
 	    $arg =~ s/\s*:\s*/:/g;
 	    $arg =~ s/\s*\[/\[/g;
 
@@ -1628,7 +1638,6 @@ sub process_state3_type($$) { 
     my $x = shift;
     my $file = shift;
 
-    $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     $x =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
     $x =~ s@^\s+@@gos; # strip leading spaces
     $x =~ s@\s+$@@gos; # strip trailing spaces
Index: linux-docbook/include/linux/usb.h
===================================================================
--- linux-docbook.orig/include/linux/usb.h	2005-11-04 22:57:57.356783495 +0100
+++ linux-docbook/include/linux/usb.h	2005-11-04 23:14:05.326614355 +0100
@@ -819,7 +819,7 @@ typedef void (*usb_complete_t)(struct ur
  */
 struct urb
 {
-	/* private, usb core and host controller only fields in the urb */
+	/* private: usb core and host controller only fields in the urb */
 	struct kref kref;		/* reference count of the URB */
 	spinlock_t lock;		/* lock for the URB */
 	void *hcpriv;			/* private data for host controller */
@@ -827,7 +827,7 @@ struct urb
 	atomic_t use_count;		/* concurrent submissions counter */
 	u8 reject;			/* submissions will fail */
 
-	/* public, documented fields in the urb that can be used by drivers */
+	/* public: documented fields in the urb that can be used by drivers */
 	struct list_head urb_list;	/* list head for use by the urb's
 					 * current owner */
 	struct usb_device *dev; 	/* (in) pointer to associated device */
@@ -1045,7 +1045,7 @@ struct usb_sg_request {
 	size_t			bytes;
 
 	/* 
-	 * members below are private to usbcore,
+	 * members below are private: to usbcore,
 	 * and are not provided for driver access!
 	 */
 	spinlock_t		lock;

--
Martin Waitz
