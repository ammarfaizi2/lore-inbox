Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRIWB5m>; Sat, 22 Sep 2001 21:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIWB5W>; Sat, 22 Sep 2001 21:57:22 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:58885 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S272158AbRIWB5Q>;
	Sat, 22 Sep 2001 21:57:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules 
In-Reply-To: Your message of "Sat, 22 Sep 2001 17:05:52 +0100."
             <E15kpHs-0003a7-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 11:56:29 +1000
Message-ID: <5633.1001210189@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001 17:05:52 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>I still have many to do. What would help me no end would be a version of
>depmod or similar which warned about modules with 
>
>o	No description
>o	No author
>o	No license tag

/sbin/modinfo $(find /lib/modules/`uname -r` -name '*.o')
lists filename, description, author, license and parms, in that order.
Extracting entries marked <none> is left as an exercise for the reader.
License is printed by modutils >= 2.4.9 (not released yet) or the patch
below against 2.4.8.

Index: 9.1/insmod/modinfo.c
--- 9.1/insmod/modinfo.c Wed, 28 Mar 2001 20:49:06 +1000 kaos (modutils-2.4/b/9_modinfo.c 1.6 644)
+++ 9.8(w)/insmod/modinfo.c Sat, 22 Sep 2001 23:17:01 +1000 kaos (modutils-2.4/b/9_modinfo.c 1.6 644)
@@ -31,6 +31,8 @@
  *   Keith Owens <kaos@ocs.com.au> December 1999.
  * Print " persistent" for persistent parameters.
  *   Keith Owens <kaos@ocs.com.au> November 2000.
+ * License support.
+ *   Keith Owens <kaos@ocs.com.au> September 2001.
  */
 
 #ident "$Id$"
@@ -249,6 +251,11 @@ static char *format_query_string(struct 
 				&out_str, last_char - out_str, 0);
 			break;
 
+		case 'l':
+			(void) append_modinfo_tag(f, "license", "<none>",
+				&out_str, last_char - out_str, 1);
+			break;
+
 		case '{':{
 				char tag[128], *end = strchr(in_str, '}');
 				int multi_line;
@@ -267,7 +274,8 @@ static char *format_query_string(struct 
 				strncpy(tag, in_str, end - in_str);
 				tag[end - in_str] = '\0';
 				multi_line = strcmp(tag, "author") == 0 ||
-					     strcmp(tag, "description") == 0;
+					     strcmp(tag, "description") == 0 ||
+					     strcmp(tag, "license") == 0;
 
 				/* Append the tag's value if it exists. */
 				append_modinfo_tag(f, tag, "<none>", &out_str, last_char - out_str, multi_line);
@@ -479,6 +487,7 @@ void modinfo_usage(void)
 	printf("usage: modinfo <options> <module>\n");
 	printf("  -a, --author            display module author\n");
 	printf("  -d, --description       display module description\n");
+	printf("  -l, --license           display module license\n");
 	printf("  -n, --filename          display module filename\n");
 	printf("  -f <str>\n");
 	printf("      --format <str>      print the <query-string>\n");
@@ -499,6 +508,7 @@ int main(int argc, char *argv[])
 	{
 		{"author", 0, 0, 'a'},
 		{"description", 0, 0, 'd'},
+		{"license", 0, 0, 'l'},
 		{"filename", 0, 0, 'n'},
 		{"format", required_argument, 0, 'f'},
 		{"parameters", 0, 0, 'p'},
@@ -507,9 +517,9 @@ int main(int argc, char *argv[])
 		{0, 0, 0, 0}
 	};
 	int do_parameters = 1, opt;
-	char *fmtstr = "filename:    %n\ndescription: %d\nauthor:      %a\n";
+	char *fmtstr = "filename:    %n\ndescription: %d\nauthor:      %a\nlicense:     %l\n";
 
-	while ((opt = getopt_long(argc, argv, "adnq:pf:Vh", long_opts, NULL)) != EOF)
+	while ((opt = getopt_long(argc, argv, "adlnq:pf:Vh", long_opts, NULL)) != EOF)
 		switch (opt) {
 		case 'a':
 			fmtstr = "%a\n";
@@ -517,6 +527,10 @@ int main(int argc, char *argv[])
 			break;
 		case 'd':
 			fmtstr = "%d\n";
+			do_parameters = 0;
+			break;
+		case 'l':
+			fmtstr = "%l\n";
 			do_parameters = 0;
 			break;
 		case 'n':

