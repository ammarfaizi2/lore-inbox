Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQLRVY0>; Mon, 18 Dec 2000 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130764AbQLRVYS>; Mon, 18 Dec 2000 16:24:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:52186 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129866AbQLRVYA>; Mon, 18 Dec 2000 16:24:00 -0500
Date: Mon, 18 Dec 2000 20:53:34 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre3ac1
Message-ID: <20001218205334.N1039@redhat.com>
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 18, 2000 at 07:40:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 07:40:03PM +0000, Alan Cox wrote:

> o	Teach kernel-doc about const			(Jani Monoses)

Needs this (also cleans up kernel-doc macro handling and fixes some
regexps):

--- linux-2.4.0test13pre3-ac1/scripts/kernel-doc	Mon Dec 18 20:46:11 2000
+++ linux-2.4.0-test13-pre3+/scripts/kernel-doc	Mon Dec 18 16:56:36 2000
@@ -668,23 +668,42 @@
 sub dump_function {
     my $prototype = shift @_;
 
-    $prototype =~ s/^const+ //;
-    $prototype =~ s/^static+ //;
-    $prototype =~ s/^extern+ //;
-    $prototype =~ s/^inline+ //;
-    $prototype =~ s/^__inline__+ //;
-    $prototype =~ s/^#define+ //; #ak added
+    $prototype =~ s/^static +//;
+    $prototype =~ s/^extern +//;
+    $prototype =~ s/^inline +//;
+    $prototype =~ s/^__inline__ +//;
+    $prototype =~ s/^#define +//; #ak added
+
+    # Yes, this truly is vile.  We are looking for:
+    # 1. Return type (may be nothing if we're looking at a macro)
+    # 2. Function name
+    # 3. Function parameters.
+    #
+    # All the while we have to watch out for function pointer parameters
+    # (which IIRC is what the two sections are for), C types (these
+    # regexps don't even start to express all the possibilities), and
+    # so on.
+    #
+    # If you mess with these regexps, it's a good idea to check that
+    # the following functions' documentation still comes out right:
+    # - parport_register_device (function pointer parameters)
+    # - atomic_set (macro)
+    # - pci_match_device (long return type)
 
     if ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
+	$prototype =~ m/^(\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
 	$return_type = $1;
 	$function_name = $2;
 	$args = $3;
@@ -729,13 +748,13 @@
 		$param="...";
 		$parameters{"..."} = "variable arguments";
 	    }
-	    if ($type eq "")
+	    elsif ($type eq "" && $param eq "")
 	    {
 		$type="";
 		$param="void";
 		$parameters{void} = "no arguments";
 	    }
-            if ($parameters{$param} eq "") {
+            if ($type ne "" && $parameters{$param} eq "") {
 	        $parameters{$param} = "-- undescribed --";
 	        print STDERR "Warning($file:$lineno): Function parameter '$param' not described in '$function_name'\n";
 	    }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
