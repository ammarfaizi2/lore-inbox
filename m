Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWIZWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWIZWEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWIZWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:04:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47773 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932435AbWIZWEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:04:45 -0400
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, junkio@cox.net
Subject: Re: git diff <-> diffstat
References: <20060924161809.GA13423@havoc.gtf.org>
	<Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
	<45172297.6070108@garzik.org>
	<Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
	<20060925011436.GC4547@stusta.de>
	<Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
Date: Tue, 26 Sep 2006 15:04:43 -0700
In-Reply-To: <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 24 Sep 2006 19:05:39 -0700 (PDT)")
Message-ID: <7vvenap9ms.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 25 Sep 2006, Adrian Bunk wrote:
>> 
>> Is there any way for "git diff" to handle additional options diffstat 
>> handles? I'm a big fan of the -w72 diffstat option.
>
> No, I think we've got the width fixed at 80 columns.

Here is a patch to lift this limit.  It also adds colors ;-).

-- >8 --
diff --stat --stat-width=72 --stat-name-width=30 --color 

This does two completely unrelated things:

 - The option --stat-width=N can be used to restrict the width of
   the output further or adjust the output for wider terminal.
   When not given the default is 80 for traditional terminals.

 - The option --stat-name-width=M can be used to set the maximum
   width used for filename part in the diffstat output.  When
   not given the default is 50.

 - With --color option, add (+) and delete (-) are colored the
   same way as added / deleted lines in the colored patch.

---
diff --git a/diff.c b/diff.c
index 443e248..5538f9a 100644
--- a/diff.c
+++ b/diff.c
@@ -545,21 +545,67 @@ static void diffstat_consume(void *priv,
 		x->deleted++;
 }
 
-static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
-static const char minuses[]= "----------------------------------------------------------------------";
 const char mime_boundary_leader[] = "------------";
 
-static void show_stats(struct diffstat_t* data)
+static int scale_change(int it, int width, int max_change)
+{
+	/*
+	 * round(width * it / max_change);
+	 */
+	return (it * width * 2 + max_change) / (max_change * 2);
+}
+
+static void show_name(const char *prefix, const char *name, int len,
+		      const char *reset, const char *fname)
+{
+	printf(" %s%s%-*s%s |", fname, prefix, len, name, reset);
+}
+
+static void show_graph(char ch, int cnt, const char *set, const char *reset)
+{
+	if (!cnt)
+		return;
+	printf("%s", set);
+	while (cnt--)
+		putchar(ch);
+	printf("%s", reset);
+}
+
+static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, len, add, del, total, adds = 0, dels = 0;
-	int max, max_change = 0, max_len = 0;
+	int max_change = 0, max_len = 0, min_change = 0;
 	int total_files = data->nr;
+	int stat_width, name_width;
+	const char *reset, *plain, *add_c, *del_c;
 
 	if (data->nr == 0)
 		return;
 
+	stat_width = options->stat_width ? options->stat_width : 80;
+	name_width = options->stat_name_width ? options->stat_name_width : 50;
+
+	if (stat_width < name_width + 10)
+		stat_width = name_width + 10; /* see below */
+
+	reset = diff_get_color(options->color_diff, DIFF_RESET);
+	plain = diff_get_color(options->color_diff, DIFF_PLAIN);
+	add_c = diff_get_color(options->color_diff, DIFF_FILE_NEW);
+	del_c = diff_get_color(options->color_diff, DIFF_FILE_OLD);
+
+	/* Find the longest filename and max/min number of changes */
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
+		int added = file->added;
+		int deleted = file->deleted;
+		int change = added + deleted;
+
+		if (0 < (len = quote_c_style(file->name, NULL, NULL, 0))) {
+			char *qname = xmalloc(len + 1);
+			quote_c_style(file->name, qname, NULL, 0);
+			free(file->name);
+			file->name = qname;
+		}
 
 		len = strlen(file->name);
 		if (max_len < len)
@@ -567,54 +613,57 @@ static void show_stats(struct diffstat_t
 
 		if (file->is_binary || file->is_unmerged)
 			continue;
-		if (max_change < file->added + file->deleted)
-			max_change = file->added + file->deleted;
-	}
+		if (max_change < change)
+			max_change = change;
+		if (0 < added && (!min_change || added < min_change))
+			min_change = added;
+		if (0 < deleted && (!min_change || deleted < min_change))
+			min_change = deleted;
+	}
+
+	/* Compute the width of the graph part;
+	 * 10 is for one blank at the beginning of the line plus
+	 * " | count " between the name and the graph.
+	 *
+	 * From here on, name_width is the width of the name area,
+	 * and stat_width is the width of the graph area.
+	 */
+	name_width = (name_width < max_len) ? name_width : max_len;
+	if (stat_width < (name_width + 10) + max_change)
+		stat_width = stat_width - (name_width + 10);
+	else
+		stat_width = max_change;
 
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
-
-		if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
-			char *qname = xmalloc(len + 1);
-			quote_c_style(name, qname, NULL, 0);
-			free(name);
-			data->files[i]->name = name = qname;
-		}
+		int name_len;
 
 		/*
 		 * "scale" the filename
 		 */
-		len = strlen(name);
-		max = max_len;
-		if (max > 50)
-			max = 50;
-		if (len > max) {
+		len = name_width;
+		name_len = strlen(name);
+		if (name_width < name_len) {
 			char *slash;
 			prefix = "...";
-			max -= 3;
-			name += len - max;
+			len -= 3;
+			name += name_len - len;
 			slash = strchr(name, '/');
 			if (slash)
 				name = slash;
 		}
-		len = max;
-
-		/*
-		 * scale the add/delete
-		 */
-		max = max_change;
-		if (max + len > 70)
-			max = 70 - len;
 
 		if (data->files[i]->is_binary) {
-			printf(" %s%-*s |  Bin\n", prefix, len, name);
+			show_name(prefix, name, len, reset, plain);
+			printf("  Bin\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
-			printf(" %s%-*s |  Unmerged\n", prefix, len, name);
+			show_name(prefix, name, len, reset, plain);
+			printf("  Unmerged\n");
 			goto free_diffstat_file;
 		}
 		else if (!data->files[i]->is_renamed &&
@@ -623,27 +672,32 @@ static void show_stats(struct diffstat_t
 			goto free_diffstat_file;
 		}
 
+		/*
+		 * scale the add/delete
+		 */
 		add = added;
 		del = deleted;
 		total = add + del;
 		adds += add;
 		dels += del;
 
-		if (max_change > 0) {
-			total = (total * max + max_change / 2) / max_change;
-			add = (add * max + max_change / 2) / max_change;
+		if (stat_width <= max_change) {
+			total = scale_change(total, stat_width, max_change);
+			add = scale_change(add, stat_width, max_change);
 			del = total - add;
 		}
-		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
-				len, name, added + deleted,
-				add, pluses, del, minuses);
+		show_name(prefix, name, len, reset, plain);		
+		printf("%5d ", added + deleted);
+		show_graph('+', add, add_c, reset);
+		show_graph('-', del, del_c, reset);
+		putchar('\n');
 	free_diffstat_file:
 		free(data->files[i]->name);
 		free(data->files[i]);
 	}
 	free(data->files);
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
-			total_files, adds, dels);
+	printf("%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
+	       plain, total_files, adds, dels, reset);
 }
 
 struct checkdiff_t {
@@ -1681,6 +1735,14 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--stat"))
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	else if (!strncmp(arg, "--stat-width=", 13)) {
+		options->stat_width = strtoul(arg + 13, NULL, 10);
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	else if (!strncmp(arg, "--stat-name-width=", 18)) {
+		options->stat_name_width = strtoul(arg + 18, NULL, 10);
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
@@ -2438,7 +2500,7 @@ void diff_flush(struct diff_options *opt
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
-		show_stats(&diffstat);
+		show_stats(&diffstat, options);
 		separator++;
 	}
 
diff --git a/diff.h b/diff.h
index b60a02e..e06d0f4 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,9 @@ struct diff_options {
 	const char *stat_sep;
 	long xdl_opts;
 
+	int stat_width;
+	int stat_name_width;
+
 	int nr_paths;
 	const char **paths;
 	int *pathlens;

