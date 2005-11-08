Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbVKHTYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbVKHTYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbVKHTYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:24:50 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:16563 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965255AbVKHTYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:24:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=LHyGCEh9944r89sBYgOADMkSos2wR/nQxNJSH4Tow78WHYZqs7sEqdvEe+OEhlWE5KX0bdlfzdMhhl1djmTTBrdoDojoPOuiue/mrG83ewbFYZS6qcQDYbmeXViVMT2pfmUTjv6OvqxBCo/Aou92W52zbCvPe70T7k47WWbPA4M=
Date: Tue, 8 Nov 2005 22:38:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] kernel-doc: nested structs and unions support
Message-ID: <20051108193810.GB14202@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam, do you like the syntax? I hope properly indented rendering will
appear soon.
------------------------------------
[PATCH 5/6] kernel-doc: nested structs and unions support

Now something like this

	struct a {
		struct b_s {
			union {
				int c;
				int g;
			} u;
		} b;
		struct d_s {
			int e;
		} d;
	};

is possible to document with the following kernel-doc comment:

	/**
	 * struct a - ...
	 *
	 * @b: ...
	 * @b.u: ...
	 * @b.u.c: ...
	 * @b.u.g: ...
	 * @d: ...
	 * @d.e: ...
	 */

Not-Yet-Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/kernel-doc |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

--- linux-kernel-doc-004/scripts/kernel-doc	2005-05-09 02:34:59.000000000 +0000
+++ linux-kernel-doc-005/scripts/kernel-doc	2005-05-09 03:46:43.000000000 +0000
@@ -104,19 +104,26 @@ use strict;
 # Beside functions you can also write documentation for structs, unions, 
 # enums and typedefs. Instead of the function name you must write the name 
 # of the declaration;  the struct/union/enum/typedef must always precede 
-# the name. Nesting of declarations is not supported. 
+# the name.
 # Use the argument mechanism to document members or constants.
 # e.g.
 # /**
 #  * struct my_struct - short description
 #  * @a: first member
 #  * @b: second member
+#  * @c: nested struct
+#  * @c.p: first member of nested struct
+#  * @c.q: second member of nested struct
 #  * 
 #  * Longer description
 #  */
 # struct my_struct {
 #     int a;
 #     int b;
+#     struct her_struct {
+#         char **p;
+#         short q;
+#     } c;
 # };
 #
 # All descriptions can be multiline, except the short function description.
@@ -156,7 +163,8 @@ my $warnings = 0;

 # match expressions used to find embedded type information
 my $type_constant = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
-my $type_param = '\@(\w+)';
+# "." is for nested structs/unions.
+my $type_param = '\@([\w.]+)';
 my $type_struct = '\&((struct\s*)?[_\w]+)';
 my $type_env = '(\$\w+)';
 
@@ -262,7 +270,8 @@ my $doc_start = '^/\*\*\s*$'; # Allow wh
 my $doc_end = '\*/';
 my $doc_com = '\s*\*\s*';
 my $doc_decl = $doc_com.'(\w+)';
-my $doc_sect = $doc_com.'(['.$doc_special.']?[\w ]+):(.*)';
+# "." is for nested structs/unions.
+my $doc_sect = $doc_com.'(['.$doc_special.']?[\w .]+):(.*)';
 my $doc_content = $doc_com.'(.*)';
 my $doc_block = $doc_com.'DOC:\s*(.*)?';
 
@@ -1292,8 +1301,22 @@ sub dump_struct($$) {
         $declaration_name = $2;
         my $members = $3;
 
-	# ignore embedded structs or unions
-	$members =~ s/{.*?}//g;
+	# Make nested structs/unions tree flat. Proceed from leaves to root.
+	# "." is needed when there is more than one level of nest.
+	while ($members =~ /{([^{]*?)}\s*([\w.]+)/) {
+	    my $inner_members = $1;
+	    my $struct_name = $2;
+
+	    # Prefix members with the name of the struct/union they are in.
+	    #	struct a {
+	    #		char *p;	=>	char *c.p
+	    #	} c;
+	    $inner_members =~ s/(\**)\s*([\w.]+)\s*;/ $1$struct_name.$2;/g;
+
+	    # Remove the leaf. Prefixed members are promoted to the next level
+	    # as if they were there from the beginning.
+	    $members =~ s/{[^{]*?}\s*([\w.]+)\s*;/$1;$inner_members/;
+	}
 
 	create_parameterlist($members, ';', $file);
 

